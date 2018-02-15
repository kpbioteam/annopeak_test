require(ChIPseeker,quiet=TRUE)
require(TxDb.Hsapiens.UCSC.hg38.knownGene,quiet=TRUE)
#require(clusterProfiler)
require(org.Hs.eg.db,quiet=TRUE)

options( show.error.messages=F, error = function () { cat( geterrmessage(), file=stderr() ); q( "no", 1, F ) } )

# we need that to not crash galaxy with an UTF8 error on German LC settings.
loc <- Sys.setlocale("LC_MESSAGES", "en_US.UTF-8")

args <- commandArgs(trailingOnly = TRUE)

input = args[1]
output1 = args[2]
output2 = args[3]

#output4 = args[5]

txdb<- TxDb.Hsapiens.UCSC.hg38.knownGene

peakAnno <- annotatePeak(input, tssRegion=c(-5000, 5000),
                         TxDb=txdb, annoDb="org.Hs.eg.db")



write.table(as.data.frame(peakAnno),file=output1,row.names=FALSE,sep="\t")

pdf(file=output2)
plotAnnoPie(peakAnno)
dev.off() 

