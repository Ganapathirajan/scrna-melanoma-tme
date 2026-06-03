# QC Summary — snRNA-seq PD Midbrain (GSE157783)

## Dataset

| Parameter | Value |
|-----------|-------|
| GEO Accession | GSE157783 |
| Tissue | Human substantia nigra pars compacta (midbrain) |
| Technology | 10x Genomics Chromium snRNA-seq |
| PD Donors | 5 (PD1–PD5) |
| Control Donors | 6 (C1–C6) |
| Total Donors | 11 |

## Variant / Nuclei Statistics

| Metric | Before QC | After QC |
|--------|-----------|----------|
| Total nuclei | 41,434 | 39,606 |
| Total genes | 26,737 | ~25,000 |
| Min genes per nucleus | — | 200 |
| Max genes per nucleus | — | 6,000 |
| Min cells per gene | — | 10 |
| Mitochondrial filter | Not applied (snRNA-seq) | Not applied |
| Retention rate | — | 95.6% |

## Clustering Summary

| Parameter | Value |
|-----------|-------|
| HVGs selected | 2,000 |
| PCA components | 40 |
| Batch correction | Harmony (batch = sample_id) |
| Clustering algorithm | Leiden (resolution = 0.5) |
| Clusters identified | 21 |

## Cell Type Composition

| Cell Type | Count | % |
|-----------|-------|---|
| Oligodendrocytes | 21,192 | 53.5 |
| Astrocytes | 4,687 | 11.8 |
| Microglia | 3,899 | 9.8 |
| OPCs | 2,751 | 6.9 |
| Excitatory Neurons | 2,062 | 5.2 |
| Endothelial Cells | 1,723 | 4.3 |
| Pericytes | 1,228 | 3.1 |
| Inhibitory Neurons | 922 | 2.3 |
| Ependymal Cells | 531 | 1.3 |
| GABA Neurons | 444 | 1.1 |
| CADPS2+ Neurons | 120 | 0.3 |
| Dopaminergic Neurons | 47 | 0.12 |
| **Total** | **39,606** | **100.0** |

## Machine Learning Summary

| Metric | Value |
|--------|-------|
| Model | Random Forest (n_estimators=200, max_depth=15) |
| Features | 2,000 HVGs |
| Subsample | 4,000 PD + 4,000 Control (balanced) |
| Validation | 5-fold stratified cross-validation |
| Mean AUC | **0.898 ± 0.005** |
| Confusion matrix TP (Control) | 3993 / 4000 |
| Confusion matrix TP (PD) | 3650 / 4000 |

## Notes

- BAM/flagstat QC metrics not available — analysis started from pre-called UMI matrix
- Mitochondrial filtering minimized as nuclear preparations contain limited cytoplasmic RNA
- Gene identifiers in Ensembl format (ENSG...) — direct symbol mapping limited by dataset format
