### DESCRIPTION ###############################################################
# Visualize differences in batches
#

### LIBRARIES #################################################################
library(imager);

rm(list = ls(all.names = TRUE));

### MAIN ######################################################################

load( 'data/2018-05-06_input.RData' );

# sample cimg file
sample.cimg.file <- '/Users/diefenbaker/Pictures/I/vlcsnap-2018-05-05-12h12m58s066.png';

sample.cimg <- load.image(sample.cimg.file);
sample.cimg <- resize(sample.cimg, size_x = -25, size_y = -25);

sample.cimg.data <- as.data.frame(sample.cimg);


## MEAN PICTURE

originals.mean <- colMeans( X[ 'originals' == Y, ], na.rm = TRUE );
prequels.mean <- colMeans( X[ 'prequels' == Y, ], na.rm = TRUE );

png(
    'plots/mean_screenshot.png',
    width = 6,
    height = 5,
    units = 'in',
    res = 500
    );

par(
    mfrow = c(2, 1),
    mar = c(0, 0.5, 1.2, 0.5)
    );

# originals
y <- originals.mean;
originals.cimg.data <- sample.cimg.data;
originals.cimg.data$value <- exp(y)/(exp(y) + 1);

originals.cimg <- as.cimg( originals.cimg.data );

plot(
    originals.cimg,
    axes = FALSE,
    rescale = FALSE,
    main = 'Originals'
    );


# prequels
y <- prequels.mean;
prequels.cimg.data <- sample.cimg.data;
prequels.cimg.data$value <- exp(y)/(exp(y) + 1);

prequels.cimg <- as.cimg( prequels.cimg.data );

plot(
    prequels.cimg, 
    axes = FALSE,
    rescale = FALSE,
    main = 'Prequels'
    );
    
dev.off();


### HISTOGRAMS

capitalize <- function(x) {
    capitalized.x <- paste0(
        toupper( substr(x, 1, 1) ),
        substr(x, 2, nchar(x))
        );

    return(capitalized.x);
}   

png(
    'plots/pre_correction_per_channel_histogram.png',
    width = 7,
    height = 5,
    units = 'in',
    res = 500
    );

par( mfrow = c(2, 3), mar = c(4, 4, 3.5, 1) );

colours <- c('red', 'green', 'blue');

for(batch in c('originals', 'prequels') ) {
    for( channel in 1:3 ) {

        channel.values <- X[ batch == Y, channel == sample.cimg.data$cc];
        y <- as.vector(channel.values);

        main <- ifelse(
            2 == channel,
            capitalize(batch),
            ''
            );

        hist(
            exp(y)/(exp(y) + 1),
            main = main,
            xlim = c(0, 1),
            ylim = c(0, 8),
            xaxs = 'i',
            yaxs = 'i',
            col = colours[ channel ],
            xlab = 'Value',
            freq = FALSE
            );
    }
}

dev.off();

