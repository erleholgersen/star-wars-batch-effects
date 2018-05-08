### DESCRIPTION ###############################################################
# Visualize results of principal component analysis.
#

### LIBRARIES #################################################################

rm(list = ls(all.names = TRUE));

### MAIN ######################################################################

load( 'data/2018-05-07_pca_results.RData' );
load( 'data/2018-05-06_input.RData' );


x <- prcomp.output$x;

# colour by batch
colour <- ifelse(
	'originals' == Y,
	'#62A0DB',
	'#D6BF7C'
	);



options(bitmapType = 'cairo');
png(
    'plots/PCA_plot.png',
    width = 6,
    height = 5,
    units = 'in',
    res = 300
    );

par(mar = c(4, 4, 0.5, 0.5));

plot(
	x[, 1:2],
	pch = 19,
	col = colour,
	bty = 'l'
	);

legend(
	'topleft',
	legend = c('Originals', 'Prequels'),
	col = c('#62A0DB', '#D6BF7C'),
	pch = 19,
	bty = 'n'
	);

dev.off();