
# test head 10
#sourmash scripts gbsketch Reference_genomes_plants_genbank.directsketch.head10.csv -c 1 -r 1 -n 1 --genomes-only -o Reference_genomes_plants_genbank.directsketch.head10.zip --failed Reference_genomes_plants_genbank.directsketch.head10.failed.csv --checksum-fail Reference_genomes_plants_genbank.directsketch.head10.checksum-fail.csv

# run full db, with batching
#sourmash scripts gbsketch Reference_genomes_plants_genbank.directsketch.csv -c 1 -r 1 -n 2 --genomes-only -o Reference_genomes_plants_genbank.directsketch.zip --failed Reference_genomes_plants_genbank.directsketch.failed.csv --checksum-fail Reference_genomes_plants_genbank.directsketch.checksum-fail.csv --batch-size 200

# cat to single db
#sourmash sig cat Reference_genomes_plants_genbank.directsketch.*.zip -o Reference_genomes_plants_genbank.directsketch.zip

# extract individual ksizes
#sourmash sig cat -k 21 Reference_genomes_plants_genbank.directsketch.zip -o genbank-plants-2024-07.k21.zip
#sourmash sig cat -k 31 Reference_genomes_plants_genbank.directsketch.zip -o genbank-plants-2024-07.k31.zip
#sourmash sig cat -k 51 Reference_genomes_plants_genbank.directsketch.zip -o genbank-plants-2024-07.k51.zip

## LINEAGES
# conda activate 2024-diversity-smash # environment containing taxonkit

# update ncbi taxdump files for taxonkit
#wget -c ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz
#tar -zxvf taxdump.tar.gz
#mkdir -p $HOME/.taxonkit
#cp names.dmp nodes.dmp delnodes.dmp merged.dmp $HOME/.taxonkit

# build lineages file
python taxid-to-lineages.taxonkit.py Rerence_genomes_plants_genbank.csv -o genbank-plants-2024-07.lineages.csv

