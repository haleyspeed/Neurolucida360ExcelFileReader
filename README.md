# Neurolucida360ExcelFileReader
Analyzes and collates the most frequently reported measurements from Neurolucida360 "all branched analysis" excel exports.

### About
If you are fortunate enough to have access to Neurolucida360 for 3D neuron reconstruction you are also unfortunate enough to how time consuming it can be to mine the "all branched analysis" spreadsheets it generates through the Explorer. This script allows you to conveniently extract the most commonly reported bits of data with only 3 lines of input. The data is output into convenient CSV files that are already formatted for descriptive statistics, ANOVAs, and hypothesis testing.

### Things you will need to change

    - getGroup() and checkGroup() items to reflect the groups in your data (lines 26-42)
    - distance calculations and variable names if you want different sized Sholl rings (lines 79-124)

