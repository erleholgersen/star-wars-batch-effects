# Test for batch effects at the pixel level
#
#

### LIBRARIES #################################################################
library(hedgehog);
library(imager);

rm(list = ls(all.names = TRUE));

### MAIN ######################################################################

load( 'data/2018-05-06_post_batch_correction_t_test_results.RData' );

sample.cimg.file <- '/Users/diefenbaker/Pictures/I/vlcsnap-2018-05-05-12h12m58s066.png';

sample.cimg <- load.image(sample.cimg.file);
sample.cimg <- resize(sample.cimg, size_x = -25, size_y = -25);

sample.cimg.data <- as.data.frame(sample.cimg);

# p-value histogram

png(
    'plots/post_correction_p_value_histogram.png',
    width = 6,
    height = 4.5,
    units = 'in',
    res = 500
    );

par( mar = c(4, 4, 0.5, 1));

hist(
    t.test.results$p.value,
    col = '#AE659D',
    xaxs = 'i',
    yaxs = 'i',
    xlab = substitute( paste(italic('p'), '-value') ),
    main = '',
    breaks = 50
    );

dev.off();
