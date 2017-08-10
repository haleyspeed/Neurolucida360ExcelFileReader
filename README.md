# Neurolucida360ExcelFileReader
Analyzes and collates the most frequently reported measurements from Neurolucida360 "all branched analysis" excel exports.

### About
If you are fortunate enough to have access to Neurolucida360 for 3D neuron reconstruction you are also unfortunate enough to how time consuming it can be to mine the "all branched analysis" spreadsheets it generates through the Explorer. This script allows you to conveniently extract the most commonly reported bits of data with only 3 lines of input. The data is output into convenient CSV files that are already formatted for descriptive statistics, ANOVAs, and hypothesis testing.

### For Detailed Information and walkthrough of logic
<a href = "https://haleygeek.com/2017/08/10/extract-data-from-neurolucida360-branched-analysis-excel-files/">&lt;N&gt;coding blog post on Neurolucida360ExcelFileReader</a>

### Things you will need to change

* getGroup() and checkGroup() items to reflect the groups in your data (lines 26-42)
* distance calculations and variable names if you want different sized Sholl rings (lines 79-124)

### The sample data

* example.xlsx <- original neurolucida xlsx file

### The sample output

* example-by branch order.csv <- summary by branch order for a single file
* example-by distance.csv <- summary by distance from soma for a single file
* example_branching.csv <- summary by branch order for an entire group
* example_distance.csv <- summary by distance from soma for an entire group
* example_summary.csv <- summary of all dendrites and spines for an entire group

### Assumptions

* Data is for all dendrites (dendrite totals).
  * Each Neurolucida360 xlsx file represents either apical or basal dendrites, not both
* The version of Neurolucida360 contains automated spine analysis
* Distance 0 μm is the point at which the dendrite contacts the cell body, not the center of the cell body
* There is ample memory for running the script repeatedly 
  * memory.limit() <- increases available memory in R in MB
  * The script was written and run with 32GB RAM on a 64-bit system
* Data is imported from and saved to the same directory
