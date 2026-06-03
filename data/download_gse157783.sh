#!/bin/bash
# Download GSE157783 dataset from NCBI GEO
# Run from repo root: bash data/download_gse157783.sh

set -euo pipefail

mkdir -p data/GSE157783_raw

BASE_URL="https://ftp.ncbi.nlm.nih.gov/geo/series/GSE157nnn/GSE157783/suppl"

FILES=(
  "GSE157783_IPDCO_hg_midbrain_UMI.tar.gz"
  "GSE157783_IPDCO_hg_midbrain_cell.tar.gz"
  "GSE157783_IPDCO_hg_midbrain_genes.tar.gz"
)

echo "Downloading GSE157783 supplementary files (~2 GB total)..."
for fname in "${FILES[@]}"; do
  echo "  Downloading ${fname}..."
  wget -q --show-progress \
    "${BASE_URL}/${fname}" \
    -O "data/GSE157783_raw/${fname}"
done

echo ""
echo "Extracting archives..."
mkdir -p data/GSE157783_extracted
for fname in "${FILES[@]}"; do
  tar -xzf "data/GSE157783_raw/${fname}" -C data/GSE157783_extracted/
  echo "  Extracted ${fname}"
done

echo ""
echo "Files ready in: data/GSE157783_extracted/"
ls data/GSE157783_extracted/
