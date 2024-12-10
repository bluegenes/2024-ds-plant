# 2024-ds-plant

Steps followed:

First, create `directsketch` file from input csv.

format:
```
accession,name,ftp_path
GCF_000001735.4,GCF_000001735.4 TAIR10.1 Arabidopsis thaliana,
GCF_030704535.1,GCF_030704535.1 ASM3070453v1 Vitis vinifera,
GCF_022201045.2,GCF_022201045.2 DVS_A1.0 Citrus sinensis,
```

### Make conda environment with directsketch and taxonkit

```
mamba create -n 2024-ds-plant sourmash_plugin_directsketch pytaxonkit
mamba activate 2024-ds-plant
```

### Use `gbsketch` to download and sketch database

```
sourmash scripts gbsketch Reference_genomes_plants_genbank.directsketch.csv -c 1 -r 1 -n 2 --genomes-only -o Reference_genomes_plants_genbank.directsketch.zip --failed Reference_genomes_plants_genbank.directsketch.failed.csv --checksum-fail Reference_genomes_plants_genbank.directsketch.checksum-fail.csv --batch-size 200
```

### Concatenate batches to a single zip file
```
sourmash sig cat Reference_genomes_plants_genbank.directsketch.*.zip -o Reference_genomes_plants_genbank.directsketch.zip
```

### For easier download, extract individual ksizes

```
sourmash sig cat -k 21 Reference_genomes_plants_genbank.directsketch.zip -o genbank-plants-2024-07.k21.zip
sourmash sig cat -k 31 Reference_genomes_plants_genbank.directsketch.zip -o genbank-plants-2024-07.k31.zip
sourmash sig cat -k 51 Reference_genomes_plants_genbank.directsketch.zip -o genbank-plants-2024-07.k51.zip
```

## Build Lineages (taxonomy) File

### update ncbi taxdump files for taxonkit

```
wget -c ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz
tar -zxvf taxdump.tar.gz
mkdir -p $HOME/.taxonkit
cp names.dmp nodes.dmp delnodes.dmp merged.dmp $HOME/.taxonkit
```

### build lineages file
This uses the `taxid` column to get lineage information from NCBI.

```
python taxid-to-lineages.taxonkit.py Rerence_genomes_plants_genbank.csv -o genbank-plants-2024-07.lineages.csv
```