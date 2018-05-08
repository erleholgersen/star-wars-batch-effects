
### DESCRIPTION ###############################################################
# Run PCA to visualize data and look for batch effects
#

### LIBRARIES #################################################################

rm(list = ls(all.names = TRUE));

### MAIN ######################################################################

load( 'data/2018-05-06_input.RData' );

X[ !complete.cases(X) ] <- min(X, na.rm = TRUE);

prcomp.output <- prcomp(X);

save(
	prcomp.output,
	file = file.path(
        'data', 
        date.stamp.file.name('pca_results.RData')
        )
	);

