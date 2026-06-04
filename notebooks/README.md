# Notebook: miniproject_snrna_pd.ipynb

The full Colab notebook is not stored in this repo due to size.

## To run

1. Open Google Colab: https://colab.research.google.com
2. Upload `workflow/miniproject_snrna_pd.py` or convert to .ipynb
3. Download GSE157783 data using `data/download_gse157783.sh`
4. Run cells in order

## Notebook structure

| Section | Description |
|---------|-------------|
| 1 | Package installation (scanpy, harmonypy, leidenalg, etc.) |
| 2 | GSE157783 data download and extraction |
| 3 | Data loading — UMI matrix (chunk-based), cell metadata, gene list |
| 4 | AnnData construction |
| 5 | Quality control filtering (violin plots) |
| 6 | Normalization + highly variable gene selection |
| 7 | PCA dimensionality reduction |
| 8 | Harmony batch correction |
| 9 | Leiden graph-based clustering |
| 10 | UMAP visualization (clusters + PD vs Control) |
| 11 | Cell type annotation (marker genes + metadata labels) |
| 12 | Dopaminergic neuron proportion analysis (boxplot) |
| 13 | Random Forest classifier (5-fold CV, ROC-AUC) |
| 14 | Feature importance analysis (top 20 genes) |
| 15 | Confusion matrix + classification report |
| 16 | Final summary printout + figure export |

## Expected runtime

~45–60 minutes on Colab free tier (T4 GPU not required)

## Notes

- UMI matrix is loaded in 500-gene chunks to avoid Colab RAM limits
- Harmony correction uses `sample_id` (donor identity) as batch variable
- Balanced subsample of 4,000 PD + 4,000 Control nuclei used for ML
