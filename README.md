# Calcium-flux-data-analysis
Converting multi channel microscopic timelapses of calcium fluxing cells into data using Imagej and Icy

Essential:
**Icy**       http://icy.bioimageanalysis.org/
**ImageJ**    https://imagej.net/
**Python 3**  https://www.python.org/downloads/
**R**         https://www.r-project.org/

Optional: 
**Visual Studio Code** https://code.visualstudio.com/
**Python extension and R extension for Visual Studio Code**
**R studio** https://www.rstudio.com/ 
**GraphPad Prism** https://www.graphpad.com/

![image](https://user-images.githubusercontent.com/71385957/139680713-6e707879-2b99-41f6-9891-2a2346d249ff.png)

Protocol:
  
1. Perform Pseudo flat-field correction
2. Convert conditions into seperate .tiff files (or other format supported by ICY | With seperated channels!)
3. Segment cells using HK-means (B cell settings provided) on the last frame.
4. Delete all non functional ROIs (False positives/Contaminations/Incomplete border cells/Untrackable cells)
5. Track cell shape using Active Contours on reversed sequence (Brightfield tracking setting) or use protocol to batch track an entire folder of sequences.



![Data analysis flow chart Image conversion drawio](https://user-images.githubusercontent.com/71385957/139682804-f939abce-ce81-4254-aed7-5d9252aab176.png)
![Data analysis flow chart Image conversion Transparant drawio](https://user-images.githubusercontent.com/71385957/139683225-2cc47ecf-6de0-40e6-a055-67734804bef9.png)
