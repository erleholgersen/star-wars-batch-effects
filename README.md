# Correcting for Batch Effects in the Star Wars Trilogies

Have you ever wanted to treat Star Wars like a microarray experiment? I have, and one day I decided to go through with it. For more details, see [my blogpost](https://erle.io/blog/adjusting-for-batch-effects-in-the-star-wars-trilogies/).

![Before after](plots/originals_exemplars.png)

The three most essential scripts are **screencapture.scpt**, **prepare_data.R** and **run_combat.R**. **screencapture.scpt** is an AppleScript that takes screenshots of a movie at 60 second intervals. After taking the screenshots, the data is converted to matrix format with **prepare_data.R**. **run_combat.R** runs the batch-correction method [ComBat](https://www.bu.edu/jlab/wp-assets/ComBat/Abstract.html). Other scripts are more of a bonus for visualization.



### Colour Spectrum
![Spatial arrangement](plots/spatial_t_test_results.png)
![Channel histograms](plots/pre_correction_per_channel_histogram.png)
