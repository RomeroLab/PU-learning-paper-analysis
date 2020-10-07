# data-r/
Takes input protein files from `data/` folder, and generate `rdata` files for each protein.

- Input: `data/[protein]/[protein]_ref_sequences_filtered.txt.gz`, `data/[protein]/[protein]_sel_sequences_filtered.txt.gz`
- Output: `[protein].rda`

# code/
## Related to fitting models,
### code/vfits

- R scripts: `vfits.R`, `vfits_i_1.R`, `vfits_i_2.R`

  - `vfits.R` contains a script fitting PU models over 20 py1 values, where at each py1 value 10-fold CV are performed.
  - `vfits_i_1.R` is a parallel version of vfits.R. It contains a script fitting PU models for one CV fold.
  - `vifts_i_2.R` is a script which aggregates 10 fitting results  from `vfits_i_1.R`

- Input: `[protein].rda` files in `data-r/``
- Output: `Rdata/vfit_[protein].Rdata `

- Scripts are run in high performance computing server environment where `protein.name` and `nCores` are provided as input arguments. (This script can be also run in a local computer as well.)

- The folder `code/vfits/Rdata/` is not uploaded in GitHub due to the file sizes. (Files can be recreated by running `vfits.R` script.)

### code/vfits

- R scripts: `fits.R`

- fits.R contains a script fitting a single PU model at a specified py1 value.

### code/enrich_comparison

- R script: `enr_test_fit.R`
- `enr_test_fit.R` contains a script fitting 10 CV PU and enrichment score models

- Input: `[protein].rda` files in `data-r/``
- Output: `Rdata/enr_r_[protein].Rdata`

- Scripts are run in high performance computing server environment where `protein.name`, `r`, and `nCores` are provided as input arguments.

- The folder `code/enrich_comparison/Rdata/` is not uploaded in GitHub due to the file sizes

## Related to results in MS

### code/roc

- R script: `rocs.R`
- Input: vfits (code/vfits/Rdata)
- Output: `[protein].eps` (for 10 proteins) (Figure 3 (a))


- R script: `aucs.R`
- Input: vfits (code/vfits/Rdata)
- Output: `aucs.csv` (Figure 3 (b) for PU model)

### code/enrich_comparison

- R script: `enr_test_summarize.R (code/enrich_comparison/Rdata)`
- Input: `enr_[r]_[protein].Rdata` (r=1,...,10)
- Output: `PU_enr_pvalue_diff.csv` (Figure 3 (c)),            `comp_enr_diff.eps` (Supplementary Figure 3 (b)),

### code/coefficient_of_variation
- R script: `cv_fold.R`
- Input: vfits (code/vfits/Rdata)
- Output: `cv_density.png` (Supplementary Figure 3 (c))

### code/coefficient_selection_stability
- R script: `stability.R`
- Input: vfits (code/vfits/Rdata)
- Output: `avg_featsel_stability.eps` (Supplementary Figure 3 (d))

### code/py1_stability
- R script: `py1_stability.R`
- Input: vfits (code/vfits/Rdata)
- Output: `py1_stability.eps` (Supplementary Figure 3 (e))

### code/fits/Bgl3_HT
- R script: `pvalues_Bgl3_HT.R`
- Input: `fit_Bgl3_HT_[r].Rdata (code/fits)`
- Output: `top_10_muts.csv` (Supplementary Figure 5 (b))
