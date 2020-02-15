# R-RoadMaps

R-RoadMaps contains two scripts to create a map by road designation, all built in R! Maps for the USA or Canada are finished; Europe and Asia are still WIP!

## To get started for a USA Map

1. Find the latitude and longitude point you would like to be at the center of your map.
2. Find the GEOIDs of counties that are within 15 miles of this point. You can look up GEOIDs here: https://census.missouri.edu/geocodes/
3. Download the shapefiles (.shp) for the roads of the counties which correspond to the GEOIDs from Step 2. Shapefiles can be downloaded from here: ftp://ftp2.census.gov/geo/tiger/TIGER2018/ROADS/
4. Download the feature name shapefiles for the GEOIDs from step 2:  https://www2.census.gov/geo/tiger/TIGER2018/FEATNAMES/
5. Set your working directory to where this file is downloaded and unzipped.
6. Run the code!

## To get started for a Canada Map

1. Download and unzip the .shp file of a province of your choice: https://open.canada.ca/data/en/dataset/82efb454-3241-4440-a5d4-8b03a42f4df8
2. Set your working directory to where this file is downloaded and unzipped.
3. Run the code!


## Example of a Map
Here is an example of San Jose, CA colored by its road designations: 
