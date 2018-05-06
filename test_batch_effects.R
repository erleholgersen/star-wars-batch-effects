### DESCRIPTION ###############################################################
# Test for batch effects at the pixel level
#
#

### LIBRARIES #################################################################
library(hedgehog);
library(pbapply);

rm(list = ls(all.names = TRUE));

### MAIN ######################################################################

load( 'data/2018-05-06_input.RData' );

t.test.results <- pbapply(
    X, 
    2, 
    FUN = function(x, group) {
        test.results <- t.test(x ~ group);
        
        return( c(test.results$estimate, test.results$p.value) );
    }, 
    group = Y
    );
    
t.test.results <- as.data.frame( t(t.test.results) );
names(t.test.results) <- c('originals.mean', 'prequels.mean', 'p.value');

t.test.results$fc <- t.test.results$prequels.mean/t.test.results$originals.mean;

t.test.results$pixel.index <- seq_len( nrow(t.test.results) );
    
save(
    t.test.results, 
    file = file.path(
        'data', 
        date.stamp.file.name('pre_batch_correction_t_test_results.RData')
        )
    );