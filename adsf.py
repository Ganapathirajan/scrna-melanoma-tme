import scvelo as scv
import scanpy as sc
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path
import sys

adata = sc.read_h5ad("GSE72056_adata.h5ad")
print(adata)

# Filter malignant cells only
adata_mal = adata[adata.obs["malignant"] == 2.0].copy()
print("Malignant cells:", adata_mal.shape)

# Reprocess malignant subset
sc.pp.highly_variable_genes(adata_mal, n_top_genes=2000)
sc.pp.pca(adata_mal)
sc.pp.neighbors(adata_mal)
sc.tl.umap(adata_mal)
sc.tl.leiden(adata_mal, resolution=0.3)

print("Clusters:", adata_mal.obs["leiden"].nunique())

import scvelo as scv

# Use scVelo's neighbor-based pseudotime
scv.pp.moments(adata_mal, n_pcs=30, n_neighbors=30)
scv.tl.velocity(adata_mal, mode="stochastic")
scv.tl.velocity_graph(adata_mal)
scv.tl.pseudotime(adata_mal)

print("Pseudotime done!")
print(adata_mal.obs["velocity_pseudotime"].describe())