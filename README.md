# scRNA-seq Cell Type Classification — Melanoma Tumor Microenvironment

![Python](https://img.shields.io/badge/Python-3.x-3776AB?style=flat-square&logo=python&logoColor=white)
![Scanpy](https://img.shields.io/badge/Scanpy-1.x-brightgreen?style=flat-square)
![sklearn](https://img.shields.io/badge/scikit--learn-RF_Classifier-orange?style=flat-square)
![GEO](https://img.shields.io/badge/GEO-GSE72056-blue?style=flat-square)
![Status](https://img.shields.io/badge/Status-Complete-success?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)

---

## Overview

Single-cell RNA-seq analysis of **melanoma tumor microenvironment (TME)** using the public dataset **GSE72056**. The project covers full preprocessing, unsupervised clustering, cell-type annotation, and a **Random Forest classifier** trained to predict cell identity from transcriptomic features.

---

## Dataset

| Field | Details |
|---|---|
| **GEO Accession** | [GSE72056](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE72056) |
| **Tissue** | Melanoma tumors (multiple patients) |
| **Organism** | *Homo sapiens* |
| **Cell types** | T cell, B cell, Macrophage, NK, CAF, Endothelial, Malignant |
| **Platform** | Smart-seq2 scRNA-seq |

---

## Analysis Pipeline

```
GEO Download → Raw count matrix
        │
        ▼
Metadata extraction (tumor_id, malignant status, cell_type)
        │
        ▼
AnnData construction + QC
  ├── Filter: min_genes=200, min_cells=3
  ├── Normalize (target_sum=1e4) + log1p
  └── Highly variable genes (n=2000)
        │
        ▼
Dimensionality Reduction
  ├── PCA (50 components)
  ├── KNN graph (n_neighbors=10, n_pcs=40)
  ├── UMAP
  └── Leiden clustering (resolution=0.5) → 20 clusters
        │
        ▼
Cell Type Annotation
  └── Marker gene dot plot (CD3D, CD68, MS4A1, VWF, FAP, NKG7, MLANA...)
        │
        ▼
ML Classification
  ├── Random Forest (100 trees, HVG features)
  ├── Train/test split (80/20, stratified)
  └── Evaluation: confusion matrix + feature importances
```

---

## Key Results

### Clustering
- **20 Leiden clusters** resolved from ~4,600 cells
- Clear separation of immune, stromal, and malignant populations on UMAP

### Random Forest Classifier

| Cell Type | Performance |
|---|---|
| B_cell | 103/103 correct |
| T_cell | 414/414 correct |
| Macrophage | 25/25 correct |
| Endothelial | 13/13 correct |
| CAF | 12/12 correct |
| NK | 3/11 correct (confused with T_cell) |

> **Overall accuracy: ~97%** — NK cells are the only challenge due to transcriptomic similarity with T cells (shared cytotoxic gene program).

### Top Predictive Features (RF)
`CD79A` · `CD3D` · `CD2` · `NCF1C` · `BLNK` · `HLA-DRA` · `MS4A1` · `BLK`

> Biologically coherent — B cell markers (CD79A, BLNK, MS4A1) and T cell markers (CD3D, CD2) dominate feature importance rankings.

---

## Visualizations

### UMAP — Clusters · Cell Types · Malignant Status
![UMAP](results/figures/GSE72056_UMAP.png)

### Marker Gene Dot Plot
![Dotplot](results/figures/dotplot__GSE72056_markers.png)

### RF Confusion Matrix
![Confusion Matrix](results/figures/GSE72056_RF_confusion.png)

### Top 20 Feature Importances
![Feature Importances](results/figures/GSE72056_RF_features.png)

---

## Repository Structure

```
ml-pathogenicity-classifier/
├── analysis/
│   ├── scrna_seq_melanoma.py     # Main pipeline (Colab)
│   └── adsf.py                   # scVelo pseudotime (malignant subset)
├── results/
│   ├── GSE72056_RF_model.pkl     # Trained RF model
│   └── figures/
│       ├── GSE72056_UMAP.png
│       ├── dotplot__GSE72056_markers.png
│       ├── GSE72056_RF_confusion.png
│       └── GSE72056_RF_features.png
└── README.md
```

---

## How to Reproduce

### Requirements

```bash
pip install scanpy leidenalg igraph scikit-learn seaborn anndata scvelo
```

### Run

```python
# Option 1: Google Colab (recommended)
# Open analysis/scrna_seq_melanoma.py in Colab — data auto-downloads from GEO

# Option 2: Local
python analysis/scrna_seq_melanoma.py
```

### Load saved model

```python
import pickle
with open("results/GSE72056_RF_model.pkl", "rb") as f:
    rf = pickle.load(f)
# rf.predict(X_new)
```

---

## Tools & Packages

| Tool | Purpose |
|---|---|
| Scanpy | QC, normalization, PCA, UMAP, Leiden clustering |
| AnnData | Single-cell data structure |
| scikit-learn | Random Forest classifier |
| scVelo | RNA velocity + pseudotime (malignant subset) |
| seaborn / matplotlib | Visualization |

---

## Author

**Ganapathirajan P**
MSc Bioinformatics & Data Science — Sathyabama Institute of Science and Technology

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=flat-square&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/grp1)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)](https://github.com/Ganapathirajan)

---

## License

MIT License — see [LICENSE](LICENSE)
