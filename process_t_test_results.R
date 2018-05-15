### DESCRIPTION ###############################################################
# Visualize results from t-tests
#

### LIBRARIES #################################################################
library(hedgehog);
library(imager);

rm(list = ls(all.names = TRUE));

### MAIN ######################################################################

load( 'data/2018-05-06_pre_batch_correction_t_test_results.RData' );

sample.cimg.file <- '/Users/diefenbaker/Pictures/I/vlcsnap-2018-05-05-12h12m58s066.png';

sample.cimg <- load.image(sample.cimg.file);
sample.cimg <- resize(sample.cimg, size_x = -25, size_y = -25);

sample.cimg.data <- as.data.frame(sample.cimg);

# p-value histogram

png(
    'plots/pre_correction_p_value_histogram.png',
    width = 6,
    height = 4.5,
    units = 'in',
    res = 500
    );

par( mar = c(4, 4, 0.5, 1));

hist(
    t.test.results$p.value,
    col = '#EFB087',
    xaxs = 'i',
    yaxs = 'i',
    xlab = substitute( paste(italic('p'), '-value') ),
    main = '',
    breaks = 50
    );

dev.off();


### FDR CORRECTED 

# multiple testing adjust
t.test.results$q.value <- p.adjust(
    t.test.results$p.value,
    method = 'fdr'
    );


dummy.cimg.data <- sample.cimg.data;

dummy.cimg.data$value <- 1;


png(
    'plots/spatial_t_test_results.png',
    width = 10,
    height = 1.6,
    units = 'in',
    res = 500
    );

par( mfrow = c(1, 3), mar = c(0.2, 0.2, 0.2, 0.2));

for( channel in 1:3 ) {

    channel.data <- dummy.cimg.data;

    channel.q.value <- t.test.results$q.value[ channel == channel.data$cc ];

    channel.data$value[ channel == channel.data$cc & t.test.results$q.value < 0.05 ] <- 1;
    channel.data$value[ channel != channel.data$cc & channel.q.value < 0.05 ] <- 0;

    plot(
        as.cimg( channel.data),
        axes = FALSE
        );
}

dev.off();


### BLACK/ WHITE

options(bitmapType = 'cairo');
png(
    'plots/vignetting_effect.png',
    width = 10,
    height = 1.6,
    units = 'in',
    res = 500
    );


min.q.value <- pmin(
    t.test.results$q.value[ 1 == dummy.cimg.data$cc ],
    t.test.results$q.value[ 2 == dummy.cimg.data$cc ],
    t.test.results$q.value[ 3 == dummy.cimg.data$cc ]
    );

par( mfrow = c(1, 3), mar = c(0.2, 0.2, 1.2, 0.2));

for( q.cutoff in c(-2, -5, -8) ) {
    dummy.cimg.data$value <- 1;
    dummy.cimg.data$value[ min.q.value < 10^q.cutoff ] <- 0;

    plot(
        as.cimg(dummy.cimg.data),
        axes = FALSE,
        main = bquote('q <' ~ 10^.(q.cutoff))
        );

}

dev.off();


