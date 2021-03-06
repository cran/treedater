## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
require(treedater)
(tre <- ape::read.tree( system.file( 'extdata', 'flu_h3n2_final_small.treefile', package='treedater') ))

## ------------------------------------------------------------------------
seqlen <- 1698 # the length of the HA sequences used to reconstruct the phylogeny

## ------------------------------------------------------------------------
sts <- sampleYearsFromLabels( tre$tip.label, delimiter='_' )
head(sts)

## ------------------------------------------------------------------------
hist( sts , main = 'Time of sequence sampling') 

## ------------------------------------------------------------------------
dtr <- dater( tre , sts, seqlen, clock = 'strict' )
dtr

## ------------------------------------------------------------------------
rt0 <- Sys.time()
dtr <- dater( tre , sts, seqlen, clock = 'strict' )
rt1 <- Sys.time()
rt1 - rt0 

## ------------------------------------------------------------------------
plot( dtr , no.mar=T, cex = .2 )

## ------------------------------------------------------------------------
rootToTipRegressionPlot( dtr )

## ------------------------------------------------------------------------
outliers <- outlierTips( dtr , alpha = 0.20) 

## ------------------------------------------------------------------------
tre2 <- ape::drop.tip( tre, rownames(outliers[outliers$q < 0.20,]) )

## ------------------------------------------------------------------------
dtr2 <- dater(tre2, sts, seqlen, clock='uncorrelated', ncpu = 1)  # increase ncpu to use parallel computing
dtr2

## ------------------------------------------------------------------------
rct <- relaxedClockTest( tre2, sts, seqlen, ncpu = 1 ) # increase ncpu to use parallel computing

## ------------------------------------------------------------------------
dtr3 <- dater( tre2, sts, seqlen, clock='strict' )
dtr3

## ------------------------------------------------------------------------
plot( dtr3 , no.mar=T, cex = .2 ) 

## ------------------------------------------------------------------------
rt2 <- Sys.time()
(pb <- parboot( dtr3, ncpu = 1) )# increase ncpu to use parallel computing
rt3 <- Sys.time()

## ------------------------------------------------------------------------
rt3 - rt2 

## ------------------------------------------------------------------------
plot( pb ) 

## ------------------------------------------------------------------------
if ( suppressPackageStartupMessages( require(ggplot2)) )
  (pb.pl <- plot( pb , ggplot=TRUE) )

## ------------------------------------------------------------------------
sts.df <- data.frame( lower = sts[1:50] - 15/365, upper = sts[1:50] + 15/365 )
head(sts.df )

## ------------------------------------------------------------------------
(dtr4 <- dater( tre2, sts, seqlen, clock='strict', estimateSampleTimes = sts.df ) )

