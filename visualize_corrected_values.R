### DESCRIPTION ###############################################################
# Visualize differences in batches after correction
#

### LIBRARIES #################################################################
library(imager);

rm(list = ls(all.names = TRUE));

### MAIN ######################################################################
load( 'data/2018-05-06_combat_results.RData' );
load( 'data/2018-05-06_input.RData' );

combat.results <- t(combat.results);


# sample cimg file
sample.cimg.file <- '/Users/diefenbaker/Pictures/I/vlcsnap-2018-05-05-12h12m58s066.png';

sample.cimg <- load.image(sample.cimg.file);
sample.cimg <- resize(sample.cimg, size_x = -25, size_y = -25);

sample.cimg.data <- as.data.frame(sample.cimg);


### HISTOGRAMS

capitalize <- function(x) {
    capitalized.x <- paste0(
        toupper( substr(x, 1, 1) ),
        substr(x, 2, nchar(x))
        );

    return(capitalized.x);
}   

png(
    'plots/post_correction_per_channel_histogram.png',
    width = 7,
    height = 5,
    units = 'in',
    res = 500
    );

par( mfrow = c(2, 3), mar = c(4, 4, 3.5, 1) );

colours <- c('red', 'green', 'blue');

for(batch in c('originals', 'prequels') ) {
    for( channel in 1:3 ) {

        channel.values <- combat.results[ batch == Y, channel == sample.cimg.data$cc];
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

