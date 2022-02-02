# McMurry 2021 - Trust in Government and Lockdown Compliance

Hello! Welcome to the GitHub page for my 2021 paper, "Trust in Government and Lockdown Compliance in Sub-Saharan Africa." My name is Charles McMurry and I wrote this paper during my senior year at UC Berkeley as my senior thesis for the economics major. I hope you find this paper fascinating and informative. Please feel free to send any questions or comments you have about it to me at charlesmcmurry@berkeley.edu!

\
In this GitHub page, you'll find these folders:
  * **Code** - R scripts I used to perform this analysis
  * **Documents** - codebooks and other information on the datasets I used
  * **Papers** - economic literature that informed this investigation

\
Additionally, I used Google Earth Engine to calculate the average nighttime luminosity within each national subregion (as a proxy for local GDP). The Google Earth Engine scripts used for this analysis are as follows:
  1. `gdp_pc` - this script was used for all national subregions NOT in Uganda. It can be found <span style="color:deepskyblue">[here](https://code.earthengine.google.com/?scriptPath=users%2Fcharlesmcmurry%2Fthesis%3Agdp_pc)</span>.
  2. `gdp_pc (eastern uganda)` - this script was used for all national subregions in Eastern Uganda. It can be found [here](https://code.earthengine.google.com/?scriptPath=users%2Fcharlesmcmurry%2Fthesis%3Agdp_pc%20(eastern%20uganda)).
  3. `gdp_pc (northern uganda)` - this script was used for all national subregion in Northern Uganda. It can be found [here](https://code.earthengine.google.com/?scriptPath=users%2Fcharlesmcmurry%2Fthesis%3Agdp_pc%20(northern%20uganda)).

\
You should be able to reproduce the results of my analysis as follows:
  1. Download the Code folder.

  2. Download the Inputs folder [here](https://drive.google.com/drive/folders/1z5aj1q4ZoSxWq6FmDAaHdJkt7zgmPrZl?usp=sharing) (it was too large to upload to GitHub). 

  3. Open `master_script.R` (found in the Code folder) using RStudio. Under "3 - Set Directory Paths", change these variables as follows:
   * `code_path` should equal the filepath of the Code folder you downloaded (as a string)
   * `input_path` should equal the filepath of the Inputs folder you downloaded (as a string)
   * `output_path` should equal the filepath of where you would like the outputs of this code to be saved (as a string)

  3. Save and run the entire `master_script.R` script. Doing so should take a few minutes as it will run all these scripts:
   * `load_data.R` - this script loads all of the datasets into R
   * `prep_data.R` - this script cleans the datasets and merges them into the final dataset used in this analysis
   * `stats.R` - this script explores and visualizes the variables in the final dataset
   * `regressions.R` - this script runs all the regressions performed in this study
    
  4. If everything worked properly, you should now be able to find all of the visualizations and regression results on your computer (at the address you used for `output_path`). If you are unable to get this to work, or if the results are different from how they appear in my paper, please contact me at the email address above.
