### DESCRIPTION ###############################################################
# Convert data to numeric and save to RData objects
#
#

### LIBRARIES #################################################################
library(hedgehog);
library(imager);

rm(list = ls(all.names = TRUE));

### MAIN ######################################################################

picture.directory <- '~/Pictures/';

X <- list();
movie <- list();

file.index <- list();

# loop over movies
for( subdirectory in c('I', 'II', 'III', 'IV', 'V', 'VI') ) {
    
    cat('Processing', subdirectory, '\n')
    
    input.files <-  list.files(
        path = file.path(picture.directory, subdirectory),
        full.names = TRUE
        );
    
    cat('\tReading cimg objects\n');
    cimg.objects <- lapply(
        input.files, 
        function(x) {
            img <- load.image(x);
            img <- resize(img, size_x = -25, size_y = -25)
            
            return( img );
            }
        );
    
    cat('\tConverting to numeric\n');
    raw.values <- lapply(
        cimg.objects,
        function(x) {
            values <- as.data.frame(x)$value;
            
            cutoff <- min( values[ 0 != values] )/2; 
            
            values[ values < cutoff ] <- cutoff;
            values[ values > 1 - cutoff] <- 1 - cutoff;
            
            logit.values <- log(values) - log( 1 - values);
            
            return( logit.values );
            }
        );
    
    X[[ subdirectory ]] <- t( do.call(cbind, raw.values) );
    file.index[[ subdirectory ]] <- data.frame(
        movie = rep(subdirectory, length(input.files)),
        file = input.files
        );
}

X <- do.call(rbind, X);
file.index <- do.call(rbind, file.index);

# add batch information
file.index$batch <- ifelse(
    file.index$movie %in% c('I', 'II', 'III'),
    'prequels',
    'originals'
    );
    
# add row number
file.index$index <- seq_len( nrow(file.index) );
    
Y <- file.index$batch;

# save to file
save(
    X, 
    Y, 
    file.index,
    file = file.path( 'data', date.stamp.file.name('input.RData') )
    );