
### DESCRIPTION ###############################################################
# Run batch correction with ComBat
#
#

### LIBRARIES #################################################################
library(sva);

rm(list = ls(all.names = TRUE));

### MAIN ######################################################################

load( 'data/2018-05-06_input.RData' );

combat.results <- ComBat(
    dat = t(X[, 1:100]),
    batch = Y
    );

# save(
#     combat.results,
#     file = file.path(
#         'data', 
#         date.stamp.file.name('combat_results.RData')
#         )
#     );