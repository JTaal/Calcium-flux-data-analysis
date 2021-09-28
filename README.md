# Calcium-flux-data-analysis
Converting multi channel microscopic timelapses into data using Imagej and Icy

Essential:
**Icy**       http://icy.bioimageanalysis.org/
**ImageJ**    https://imagej.net/
**Python 3**  https://www.python.org/downloads/
**R**         https://www.r-project.org/

Optional: https://code.visualstudio.com/, Python extension for VS Code or other python interpreter, R extension for Visual Studio Code or https://www.rstudio.com/, https://www.graphpad.com/

The first step is to open up the project and apply a pseudo-flat-field correction on the IRM channel using a macro written in the ImageJ macro language. 

Once that is done all the individual sequences have to be saved to a folder and a single one loaded into ICY. Within ICY it is important to change the colourmap of the IRM and Brightfield channels to sensible colours. Then turn off the display of the channel you won’t be using to see the cells or adhesion. This change is only visually all the channels can always be accessed by plugins or ICY base modules. It is important that the brightness stays exactly the same for the calcium channel, because this will create a shift in intensity values! Once that is done the sequence needs to be closed. This prompts ICY to create an .XML metadata file next to the sequence in the folder it was loaded in from. To save you the trouble of changing the colourmaps of all the sequences, the metadata can be copied across similar sequences (needs to be the same channels and microscope settings) with different lengths. After that all the sequences need to be loaded into the ICY to draw ROIs over the cells. 

To do this the videos first need to be reversed in time, then the HK-means plugin needs to be opened. The size of the B cells depends on the total zoom of the microscope. The file HK-means B cell profile was created to work on a 20x objective with an additional 2.5 to 4.5x zoom. Once the cells are segmented the HK-means detections have to be dilated to fit better on the B cell and change the detections into 2D ROIs. Then the cells have to be selected for non sensical detections, contaminations, dead cells, cells that will overlap during tracking. Special care needs to be given to cells close to the border. Depending on the direction of landing cells can create and infinitely expanding tracking ROI once they leave the field of view. This creates a great hazard for batch processing videos, because one cell can put a complete halt to the tracking of the video and every subsequent video. The best way to get rid of these cells is by deleting ROIs on cells that move towards the border at the end of the reversed video. 

Once all the sequences are vetted the entire process can be done in batch using the sequence batch tracking calcium.protocol. This will track all the different sequences from a single folder and output the datatypes (mean intensity, sum intensity and area) in .csv files delineated by tabs. These can be converted using the ICY data conversion.py script to make it compatible for the data orientation corrections.R script.

If different data output is required or only a single sequence needs to be tracked the manual approach might be more suitable. This is shown in the video and follows a similar approach to the ICY protocol. You’d have to load in the sequence then reverse the timeframe again (this isn’t saved unless you actually save the sequence in reverse, this however is not advisable because when making your sequences mutable you lose the ability to backtrack. Potentially forcing you to redo certain parts of the data analysis pipeline. Costing precious time.). Then you can open active contours and the Brightfield tracking setting.file or Brightfield tracking settings.file and track the cells on the sequence. Once the cells are tracked the send to trackmanager button will send the TrackGroup to the trackmanager and from there on you are able to extract out any data using the ROIStatisticsTrackProcessor.
