import pickle
import random
import sys
import time

import numpy as np
import pandas as pd

sys.path.insert(0, './DeepSequence')
from DeepSequence import helper, model, train

start_f = time.time()

print(start_f)

direc = sys.argv[1]
if direc[-1] != '/':
    direc += '/'

dataset = direc.split('/')[0]

data_params = {
    "dataset"           :   dataset
    }

model_params = {
    "bs"                :   100,
    "encode_dim_zero"   :   1500,
    "encode_dim_one"    :   1500,
    "decode_dim_zero"   :   100,
    "decode_dim_one"    :   500,
    "n_latent"          :   30,
    "logit_p"           :   0.001,
    "sparsity"          :   "logit",
    "f_nonlin"          :  "sigmoid",
    "fps"               :   True,
    "n_pat"             :   4,
    "r_seed"            :   1,
    "conv_pat"          :   True,
    "d_c_size"          :   40,
    "sparsity_l"        :   1.0,
    "l2_l"              :   1.0,
    "dropout"           :   True,
    }

train_params = {
    "num_updates"       :   5000,
    "save_progress"     :   True,
    "verbose"           :   True,
    "save_parameters"   :   False,
    }


def one_index(line):
    mutations = [(int(m[1:-1])+1, m[0], m[-1]) for m in line.split(',')]
    return mutations


if __name__ == "__main__":

    print 'start', time.time() - start_f
    sys.stdout.flush()

    data_helper = helper.DataHelper(alignment_file=direc+'aln_filtered.fasta')

    print 'data_helper loaded: %s' % (time.time() - start_f)
    sys.stdout.flush()

    vae_model   = model.VariationalAutoencoderMLE(data_helper,
        batch_size                     =   model_params["bs"],
        encoder_architecture           =   [model_params["encode_dim_zero"],
                                                model_params["encode_dim_one"]],
        decoder_architecture           =   [model_params["decode_dim_zero"],
                                                model_params["decode_dim_one"]],
        n_latent                       =   model_params["n_latent"],
        logit_p                        =   model_params["logit_p"],
        encode_nonlinearity_type       =   "relu",
        decode_nonlinearity_type       =   "relu",
        final_decode_nonlinearity      =   model_params["f_nonlin"],
        final_pwm_scale                =   model_params["fps"],
        conv_decoder_size              =   model_params["d_c_size"],
        convolve_patterns              =   model_params["conv_pat"],
        n_patterns                     =   model_params["n_pat"],
        random_seed                    =   model_params["r_seed"],
        sparsity_lambda                =   model_params["sparsity_l"],
        l2_lambda                      =   model_params["l2_l"],
        sparsity                       =   model_params["sparsity"])

    print 'model loaded: %s' % (time.time() - start_f)
    sys.stdout.flush()

    job_string = helper.gen_job_string(data_params, model_params)
    print 'string generated: %s' % (time.time() - start_f)
    sys.stdout.flush()

    train.train(data_helper, vae_model,
        num_updates             =   train_params["num_updates"],
        save_progress           =   train_params["save_progress"],
        save_parameters         =   train_params["save_parameters"],
        verbose                 =   train_params["verbose"],
        job_string              =   job_string)

    print 'trained: %s' % (time.time() - start_f)
    sys.stdout.flush()

    vae_model.save_parameters(file_prefix=job_string)

    print 'Reading in data'
    num_muts = 500
    with open(direc + 'ref_mutations.txt') as f:
        unl_lines = [line for line in f if line.strip() and '*' not in line]
        unl_sample = random.sample(unl_lines, num_muts)
        unl_muts = [(one_index(line.strip()), 0) for line in unl_sample]
    with open(direc + 'sel_mutations.txt') as f:
        pos_lines = [line for line in f if line.strip() and '*' not in line]
        pos_sample = random.sample(pos_lines, num_muts)
        pos_muts = [(one_index(line.strip()), 1) for line in pos_sample]
    muts = pd.DataFrame(unl_muts + pos_muts, columns=['mutant', 'f'])
    print 'data read: %s' % (time.time() - start_f)
    sys.stdout.flush()

    print 'testing mutants: %i' % muts.shape[0]
    for i, row in muts.iterrows():
        print "%i\r" % i,
        sys.stdout.flush()
        m = row['mutant']
        e = data_helper.delta_elbo(vae_model, m)
        muts.at[i, 'pred'] = e
    print '\n'
    muts.to_pickle(direc + 'DeepSequence_results.p')

    print time.time() - start_f
