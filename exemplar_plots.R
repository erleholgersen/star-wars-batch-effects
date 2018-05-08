### DESCRIPTION ###############################################################
# Plot selected screenshots before and after batch adjustment
#

### LIBRARIES #################################################################
library(hedgehog);
library(pbapply);
library(imager);

rm(list = ls(all.names = TRUE));

### MAIN ######################################################################

load( 'data/2018-05-06_combat_results.RData' );
load( 'data/2018-05-06_input.RData' );

# should have done this before saving...
file.index$file <- as.character( file.index$file );


combat.results <- t(combat.results);


### ORIGINALS

original.indices <- c(402, 416, 475, 501, 640)

n <- length(original.indices);

options(bitmapType = 'cairo');
png(
    'plots/originals_exemplars.png',
    width = 6,
    height = 7.5,
    units = 'in',
    res = 300
    );


par( mfrow = c(n, 2), mar = c(0, 0.2, 1, 0.2) );

# sample three images and plot before/ after
for( i in original.indices ) {

	cat(i, '\n');

	# read in file
	original.cimg <- load.image( file.index$file[i] );
	original.cimg <- resize(original.cimg, size_x = -25, size_y = -25);

	# plot
	plot(
		original.cimg, 
		rescale = FALSE, 
		axes = FALSE,
		main = ifelse(original.indices[1] == i, 'Raw', '')
		);


	# plot combat-adjusted version
	combat.cimg.data <- as.data.frame( original.cimg );

	y <- combat.results[i, ];

	combat.cimg.data$value <- exp(y)/(exp(y) + 1);

	combat.cimg <- as.cimg(combat.cimg.data);

	plot(
		combat.cimg, 
		rescale = FALSE, 
		axes = FALSE,
		main = ifelse(original.indices[1] == i, 'ComBat-adjusted', '')
		);

}

dev.off();


### PREQUELS

prequel.indices <- c(65, 149, 203, 310, 315);

n <- length(prequel.indices);

options(bitmapType = 'cairo');
png(
    'plots/prequels_exemplars.png',
    width = 6,
    height = 7.5,
    units = 'in',
    res = 300
    );


par( mfrow = c(n, 2), mar = c(0, 0.2, 1, 0.2) );

# sample three images and plot before/ after
for( i in prequel.indices ) {

	cat(i, '\n');

	# read in file
	original.cimg <- load.image( file.index$file[i] );
	original.cimg <- resize(original.cimg, size_x = -25, size_y = -25);

	# plot
	plot(
		original.cimg, 
		rescale = FALSE, 
		axes = FALSE,
		main = ifelse(prequel.indices[1] == i, 'Raw', '')
		);


	# plot combat-adjusted version
	combat.cimg.data <- as.data.frame( original.cimg );

	y <- combat.results[i, ];

	combat.cimg.data$value <- exp(y)/(exp(y) + 1);

	combat.cimg <- as.cimg(combat.cimg.data);

	plot(
		combat.cimg, 
		rescale = FALSE, 
		axes = FALSE,
		main = ifelse(prequel.indices[1] == i, 'ComBat-adjusted', '')
		);

}

dev.off();
