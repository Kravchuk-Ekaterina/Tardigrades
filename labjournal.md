# Tardigrades: labjournal

## 0. Obtaining data
```bash
wget http://kumamushi.org/data/YOKOZUNA-1.scaffolds.fa
```
I renamed the file "tardigrade.fa"

## 1. Repeat masking (was preprocessed)
Eukaryotic genomes are rich in repeats. If all repeats won't be hidden (masked) they result in BLAST matches that produce false evidence for genome annotation. Repeat masking is usually performed with the help of RepeatMasker (it is based on reference repeat database, so it is necessary to chose closest relative repeats as a reference), but in our case it is better to use RepeatModeller (it can predict novel repeat families)

## 2. Gene prediction (was preprocessed)
"AUGUSTUS has currently been trained on species-specific training sets to predict genes in the limited list of species. The good news is that, for closely-related species, we usually only need one training set. For example, the human version is good for all mammals."<br>

While working with augustus it is better to choose closest availible relative of tardigrates. We can use a phyloT service (which draws a philogenetic tree) to identify closest relative<br>
### Installing augustus
```bash 
conda install -c bioconda augustus
```
### Processing data
After processing data in augustus we get the augustus.whole.gff file (and remane it to genome_ann.gff). With the help of getAnnoFasta.pl we extracted proteins sequences and count them
```bash
perl getAnnoFasta.pl genome_ann.gff
```
Can't open perl script "getAnnoFasta.pl": No such file or directory
got genome_ann.aa Rename it to proteins.fasta
```bash
mv genome_ann.aa proteins.fasta
```
Calculating the number of proteins
```bash
cat genome_ann.aa | grep ">" | wc -l
```
The output:
16435

## 3. Model training (was preprocessed)
tardigrates is pretty far from pre-calculated models, so we can create specific model providing our own RNA-seq data. A full-length cDNA dataset was created for R. varieornatus using Sanger sequencing. We may train model on the base of this data and then use model to annotate the genome

## 4. Functional annotation 
I used https://github.com/tejashree1modak/AUGUSTUS-helpers to obtain protein coding sequences
```bash
bash get-fasta.sh augustus.whole.gff
```
Then I counted the number of sequences:
```bash
grep -c ">" protein.fasta
```
The output: 16435

## 5. Physical localization
peplides.fa is a file containing list of peptides that were associated with the DNA. The data is obtained from tandem mass spectrometry experiments using chromatin fraction. <br>
### Creating blast database and doing a local blast search:
Creating database:
```bash
makeblastdb -in protein.fasta -dbtype prot -out proteins_db
```
Running blastp:
```bash 
blastp -query peptides.fa   -db proteins_db  -out proteins.blastp -outfmt "6 qseqid sseqid evalue qcovs pident" -evalue 0.05  -task blastp-short

```
So we have proteins.blastp file. Using a python script phys_loc.py. It can be found in ./scripts.<br>
The head of the table:<br>
![phys_loc](./images/phys_loc.jpg "phys_loc") <br>
There are 44 proteins in it<br>

### Extracting protein sequences
I created the script extract_seq.py to do this. It can be found in ./scripts. The script creates file protein_1.fasta with the extracted sequences<br>
```bash
grep -c ">" protein_1.fasta
```
The output is 15. There are 15 extracted sequences

## 6. Localization prediction
### WoLF PSORT
Protein Subcellular Localization Prediction https://wolfpsort.hgc.jp/ <br>
The results:<br>
<br>
g4106 details E.R.: 14.5, E.R.golg: 9.5, extr: 7, golg: 3.5, lyso: 3, pero: 2, plas: 1, mito: 1 <br>
g5237 details plas: 24, mito: 8 <br>
g5467 details extr: 27, plas: 4, mito: 1 <br>
g5502 details extr: 31, lyso: 1 <br>
g5503 details extr: 29, plas: 1, mito: 1, lyso: 1 <br>
g5510 details plas: 23, mito: 7, E.R.: 1, golg: 1 <br>
g5616 details extr: 31, mito: 1 <br>
g5641 details extr: 31, lyso: 1 <br>
g10513 details nucl: 20, cyto_nucl: 14.5, cyto: 7, extr: 3, E.R.: 1, golg: 1 <br>
g12510 details plas: 29, cyto: 3 <br>
g12562 details extr: 30, lyso: 2 <br>
g13530 details extr: 13, nucl: 6.5, lyso: 5, cyto_nucl: 4.5, plas: 3, E.R.: 3, cyto: 1.5 <br>
g14472 details nucl: 28, plas: 2, cyto: 1, cysk: 1 <br>
g15153 details extr: 32 <br>
g15484 details nucl: 17.5, cyto_nucl: 15.3333, cyto: 12, cyto_mito: 6.83333, plas: 1, golg: 1

### TargetP Server

https://services.healthtech.dtu.dk/service.php?TargetP-2.0 <br>
 The location assignment is based on the predicted presence of any of the N-terminal presequences<br>
The results: <br>
<br>
![pred_prot1](./images/pred_prot1.jpg "pred_prot1") <br>
![pred_prot2](./images/pred_prot2.jpg "pred_prot2") <br>
![pred_prot3](./images/pred_prot3.jpg "pred_prot3") <br>

## 7. BLAST search
BLASTing (https://blast.ncbi.nlm.nih.gov) protein sequences against ???UniProtKB/Swiss-Prot??? database.<br>
The settings: <br>
![blast](./images/blast.jpg "blast") <br>
You can find the results in blast_results.csv<br>

## 8. Pfam prediction
Proteins that were not recognised by BLAST were processed in HMMER (HMMER search protein sequences against a collection of profile-HMMs for different protein domains and motifs) https://www.ebi.ac.uk/Tools/hmmer/

## 9. Integrating our various pieces of evidence
Created a table where for each protein, you provide the following information (if any is available): <br>
a) best blast hit (annotation and e-value)<br>
b) predicted Pfam domains<br>
c) probable localization(s) according to WoLF PSORT<br>
d) localization according to TargetP<br>
I combined the results using script Project4.R (it can be found in scripts/ directory)<br>
The output file is results.csv

