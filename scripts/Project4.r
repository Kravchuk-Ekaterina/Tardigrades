# BLAST results
library(readr)
results <- read_csv("blast_results.csv")
sequence <- c("g4106.t1", "g5237.t1", "g5510.t1", "g10513.t1", "g12510.t1", "g13530.t1", "g14472.t1")
nones <- c('-', '-', '-', '-', '-', '-', '-')
num <- c(9, 10, 11, 12, 13, 14, 15)
results_2 <- as.data.frame(num)
results_2$sequence <- sequence
results_2$Accession_number <- nones
results_2$evalue <- nones
results_2$identity <- nones
results_2$querty_cover <- nones

names(results)[1]<-paste("num")
names(results)[5]<-paste("identity")
names(results_2)[6]<-paste("query_cover")
results <- rbind(results, results_2)

# WoLF PSORT prediction
results$WoLF_pediction <- c('extr: 27, plas: 4, mito: 1', 'extr: 31, mito: 1', 'extr: 32', 'extr: 29, plas: 1, mito: 1, lyso: 1', 'extr: 31, lyso: 1', 'extr: 31, lyso: 1', 'extr: 30, lyso: 2', 'nucl: 17.5, cyto_nucl: 15.3333, cyto: 12, cyto_mito: 6.83333, plas: 1, golg: 1', 'E.R.: 14.5, E.R.golg: 9.5, extr: 7, golg: 3.5, lyso: 3, pero: 2, plas: 1, mito: 1', 'plas: 24, mito: 8', 'plas: 23, mito: 7, E.R.: 1, golg: 1', 'nucl: 20, cyto_nucl: 14.5, cyto: 7, extr: 3, E.R.: 1, golg: 1', 'plas: 29, cyto: 3', 'extr: 13, nucl: 6.5, lyso: 5, cyto_nucl: 4.5, plas: 3, E.R.: 3, cyto: 1.5', 'nucl: 28, plas: 2, cyto: 1, cysk: 1')

# TargetP prediction
results$TargetP_type <- c('Signal peptide', 'Signal peptide', 'Signal peptide', 'Signal peptide', 'Signal peptide', 'Signal peptide', 'Signal peptide', 'Other', 'Other', 'Other','Other', 'Other', 'Other', 'Signal peptide', 'Other')
results$TargetP_likelihood <- c(0.9998, 0.9999, 1, 0.9987, 0.9988, 0.9999, 0.9999, 1, 0.7297, 0.9995, 0.9991, 1, 0.9997, 0.8838, 1)

# Pfam
results$pfam_prediction <- c('-', '-', "Chitin binding Peritrophin-A domain", '-', '-', "Chitin binding Peritrophin-A domain", "Chitin binding Peritrophin-A domain", '-', "Chitin binding Peritrophin-A domain", '-', "Chitin binding Peritrophin-A domain", "Chitin binding Peritrophin-A domain", "Chitin binding Peritrophin-A domain", "Vps51/Vps67||Vacuolar-sorting protein 54, of GARP complex||Exocyst complex component Sec5||Dor1-like family||COG (conserved oligomeric Golgi) complex component, COG2", '-')

# Saving results to csv
write.csv(results,"results.csv", row.names = FALSE)

