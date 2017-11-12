# Neurolucida360ExcelFileReader
Analyzes and collates the most frequently reported measurements from Neurolucida360 "all branched analysis" excel exports.

#### About
If you are fortunate enough to have access to Neurolucida360 for 3D neuron reconstruction you are also unfortunate enough to how time consuming it can be to mine the "all branched analysis" spreadsheets it generates through the Explorer. This script allows you to conveniently extract the most commonly reported bits of data with only 3 lines of input. The data is output into convenient CSV files that are already formatted for descriptive statistics, ANOVAs, and hypothesis testing by additional scripts in this repository.

#### Inlcuded Scripts
* NeurolucidaExcelReader.R
* MorphologySummary.R
* MorphologyBranching.R
* MorphologyDistance.R

## NeurolucidaExcelReader.R

#### What it does

* Reads in a single xlsx file output by "all branched analysis" in the Neurolucida 360 explorer. This xlsx file is automatically generated by Neurolucida360 and contains 12 worksheets. 
* Extracts the data into 3 csv files: summary for the entire dendritic structure, summary by dendrite branch order, summary by distance from soma

#### For Detailed Information and walkthrough of logic
<a href = "https://haleygeek.com/2017/08/10/neurolucida360excelfilereader/">&lt;N&gt;coding blog post on Neurolucida360ExcelFileReader</a>

#### Assumptions

* Data is for all dendrites (dendrite totals).
  * Each Neurolucida360 xlsx file represents all dendrites
  * If you want to analyze apical and basal dendrites separately, they should be be analyzed separately in Neurolucida Explorer 
* The version of Neurolucida360 contains automated spine analysis (12 worksheets per xlsx file)
* Distance 0 μm is the point at which the dendrite contacts the cell body, not the center of the cell body
* Data is imported from and saved to the same directory

#### Things you will need to change

* find and replace "group1", "group2", "group3", and "group4" with your group names
* Edit the getUserInput() function to reflect the number of distance calculations and variable names if you want different sized Sholl rings (lines 79-124)

#### The sample input data

* example.xlsx <- original neurolucida xlsx file

#### The sample output

* example-by branch order.csv <- summary by branch order for a single file
* example-by distance.csv <- summary by distance from soma for a single file
* example_branching.csv <- summary by branch order for an entire group
* example_distance.csv <- summary by distance from soma for an entire group
* example_summary.csv <- summary of all dendrites and spines for an entire group

#### Dependencies

* openxlsx
* dplyr




## Morphology Summary.R

#### What it does

* Reads in the summary.csv files created by the Neurolucida360ExcelReader.R script
* Calculates descriptive statistics (mean, sd, se, n)
* Performs a one-way ANOVA on every possible combination of groups for
  *  Dendrite length
  *  Dendrite surface area
  *  Dendrite volume
  *  Number of dendrite branches
  *  Number of orders of dendrites
  *  Total spine area
  *  Total spine volume
  *  Total spine density
  *  Thin spine density
  *  Stubby spine density
  *  Mushroom spine density
  *  Filopodia density 
* Calculates 95% confidence intervals for each possible combination of groups


#### For Detailed Information and walkthrough of logic
<a href = "https://haleygeek.com/2017/08/12/morphologysummary/">&lt;N&gt;coding blog post on Neurolucida360ExcelFileReader</a>

#### Assumptions

* Data is saved to a new subdirectory named "analyzed" within the user-entered file path
* User-specified csv files were generated by Neurolucida360ExcelFileReader.R or are organized with the same column names and structure

#### Things you will need to change

* Edit the getUserInput() function to reflect the number of groups in your datasetEdit the number of groups in each comparison (data.compare1, data.compare2, etc..). 

* Default is comparing groups pairwise, but a third group can be easily added in the "# Combine data for comparison between exposure/treatment groups" section by replacing the line: 

   <code> data.compare1 <- rbind(data.group1, data.group2, data.group3)</code> 
 
   with the line 
 
   <code> data.compare1 <- rbind(data.group1, data.group2, data.group3)</code> 

   Next, in the "Assemble ANOVA outputfile" the line: 

   <code>file.compare1 <- paste(group.name1,group.name2, sep = "_vs_")</code> 

   should be replaced by the lines: 

   <code>file.compare1 <- paste(group.name1,group.name2, sep = "_vs_") 
   file.compare1 <- paste(file.compare1,group.name3, sep = "_vs_")</code> 

* More advanced users can alter the "# Assemble ANOVA output file" block for custom output file names and edit output filename extensions or directory for analyzed files.

#### The sample input data

* example_summary.csv <- template for input csv file for each group

#### The sample output

* example_descriptive.csv <- descriptive statistics for a single group (mean, stdDev, stdErr, n)
* example-anova.csv <- one-way anova results table for each possible comparison between groups (pairwise) 
* example_confidence.csv <- 95% confidence intervals for each possible comparison between groups (pairwise)

#### Dependencies

* nlme
* dplyr
* rcompanion
