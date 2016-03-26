Logistic regression classification of SF crimes

The SF crime dataset used here contains over 800,000 rows of data in the below
format:

2003-01-06 00:31:00,"OTHER, OFFENSES","DRIVERS LICENSE, SUSPENDED OR REVOKED",Monday,RICHMOND,"ARREST, CITED",CLEMENT ST / 14TH AV,-122.472984835661,37.7825523645525

Each row includes the time, place, and category of crime. There are 39 different
categories. These scripts build a logistic regression model that can predict the
category of crime given the time and place.

To run, first build and run the container:

   docker build -t sfcrime .
   docker run -v `pwd`/src:/src/sfcrime -v `pwd`/data:/data/sfcrime -i -t docker bash

Next from inside the container use the make.sh script to parse the data into a
format that can be easily loaded into Octave:

   ./make.sh parsetrain

Finally use octave to build engineered features, train the classifier on a
random sampled subset of the data, and finally classify using that model:

   octave
   octave> sfcrimeFeatures
   octave> sfcrimeTrain
   octave> sfcrimeClassify

That's it! You should get a 23% prediction accuracy.
