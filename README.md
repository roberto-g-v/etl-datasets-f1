# F1 ETL Process
## Contributors
* Matheus Gratz - matheusgratz@gmail.com [![GitHub](social_icons/gthb.png)](https://github.com/matheusgratz/)  [![Linkedin](social_icons/lkdin.png)](https://www.linkedin.com/in/matheusgratz/) [![Twiter](social_icons/twtr.png)](https://twitter.com/matheusgratz)  
* Sergio Guarneros - sergioguarneros95@gmail.com [![GitHub](social_icons/gthb.png)](https://github.com/SergioGL8/)  [![Linkedin](social_icons/lkdin.png)](https://www.linkedin.com/in/sergio-guarneros-luna-1990/) [![Twiter](social_icons/twtr.png)](https://twitter.com/zerchluna)  
* Roberto Gonzalez - roberto.gonzalez.vallejo@gmail.com [![GitHub](social_icons/gthb.png)](https://github.com/roberto-g-v/)  [![Linkedin](social_icons/lkdin.png)](https://www.linkedin.com/in/roberto-gonzalez-vallejo-6ba894144/) [![Twiter](social_icons/twtr.png)](https://twitter.com/RobertoGlezV)  

---
Table of contents <a name="toc"></a>

1. [Kaggle Dataset](#kaggle)
2. [ERD](#erd)
3. [postgreSQL Statatements](#psql)
4. [Jupyter Notebook File](#jnb)
5. [Answers](#ans)

---
### The Dataset (Kaggle) <a name="kaggle"></a>

We've used a Kaggle dataset to perform this task. In this case, we choose a [F1 race data from 1950 to 2020](https://www.kaggle.com/rohanrao/formula-1-world-championship-1950-2020).

The dataset has multiple files:
* <span style="background-color:#D3D3D3">circuits.csv</span>
* constructor_results.csv
* constructor_standings.csv
* constructors.csv
* driver_standings.csv
* <span style="background-color:#D3D3D3">drivers.csv</span>
* lap_times.csv
* pit_stops.csv
* qualifying.csv
* <span style="background-color:#D3D3D3">races.csv</span>
* <span style="background-color:#D3D3D3">results.csv</span>
* seasons.csv
* status.csv

From the 13 files, we've decided to use 4 files to define and execute the ETL process. Those files are highlighted in gray in the previous list presented.

The data selection was based on the questions that we want to answer, as below:
1. What's the distribution of drivers based on their nationality?
Based on the nationality: 
2. What's the distribution of winners?
3. What's the distribution of 2nd places?
4. What's the distribution of 3rd places?
5. What's the distribution of podium appearances?

Also, some columns either had a lot of NaN values or did not add any value to our analysis. In this case, we've decided to drop them.

---
### ERD <a name="erd"></a>

<sub><sup>[Go back to the table of contents](#toc)</sub></sup>

Use http://www.quickdatabasediagrams.com to define ERD of tables.
<br>
In order to replicate the same relationships, you can use the code as follows:

~~~sql
    circuits
    --
    circuitId INT PK
    circuitRef VARCHAR
    name VARCHAR
    location VARCHAR
    country VARCHAR
    lat DECIMAL
    lng DECIMAL

    drivers
    --
    driverId INT PK
    driverRef VARCHAR
    code VARCHAR
    forename VARCHAR
    surname VARCHAR
    dob DATE
    nationality VARCHAR

    races
    --
    raceId INT PK
    year INT
    round INT
    circuitId INT FK >- circuits.circuitId
    name VARCHAR
    date DATE

    results
    --
    resultId INT PK
    raceId INT FK >- races.raceId
    driverId INT FK >- drivers.driverId
    grid INT
    position INT
    points INT
    laps INT
    time VARCHAR
    milliseconds VARCHAR 
    fastestLap VARCHAR
    fastestLapTime VARCHAR 
    fastestLapSpeed VARCHAR
~~~

---
### postgreSQL Statatements <a name="psql"></a>
<sub><sup>[Go back to the table of contents](#toc)</sub></sup>

With the ERD, you can export the SQL statatements to postgreSQL format and import to query editor to create tables and stablish relationships. 
<br>
<br>
The code is as follows:

~~~sql
DROP TABLE IF EXISTS results;
DROP TABLE IF EXISTS races;
DROP TABLE IF EXISTS drivers;
DROP TABLE IF EXISTS circuits;

CREATE TABLE "circuits" (
    "circuitId" INT   NOT NULL,
    "circuitRef" VARCHAR   NOT NULL,
    "name" VARCHAR   NOT NULL,
    "location" VARCHAR   NOT NULL,
    "country" VARCHAR   NOT NULL,
    "lat" DECIMAL   NOT NULL,
    "lng" DECIMAL   NOT NULL,
    CONSTRAINT "pk_circuits" PRIMARY KEY (
        "circuitId"
     )
);

CREATE TABLE "drivers" (
    "driverId" INT   NOT NULL,
    "driverRef" VARCHAR   NOT NULL,
    "code" VARCHAR,
    "forename" VARCHAR   NOT NULL,
    "surname" VARCHAR   NOT NULL,
    "dob" DATE,
    "nationality" VARCHAR   NOT NULL,
    CONSTRAINT "pk_drivers" PRIMARY KEY (
        "driverId"
     )
);

CREATE TABLE "races" (
    "raceId" INT   NOT NULL,
    "year" INT   NOT NULL,
    "round" INT   NOT NULL,
    "circuitId" INT   NOT NULL,
    "name" VARCHAR   NOT NULL,
    "date" DATE   NOT NULL,
    CONSTRAINT "pk_races" PRIMARY KEY (
        "raceId"
     )
);

CREATE TABLE "results" (
    "resultId" INT   NOT NULL,
    "raceId" INT   NOT NULL,
    "driverId" INT   NOT NULL,
    "grid" INT   NOT NULL,
    "position" INT,
    "points" INT   NOT NULL,
    "laps" INT   NOT NULL,
    "time" VARCHAR,
    "milliseconds" VARCHAR,
    "fastestLap" VARCHAR,
    "fastestLapTime" VARCHAR,
    "fastestLapSpeed" VARCHAR,
    CONSTRAINT "pk_results" PRIMARY KEY (
        "resultId"
     )
);

ALTER TABLE "results" ADD CONSTRAINT "fk_results_driverId" FOREIGN KEY("driverId")
REFERENCES "drivers" ("driverId");

ALTER TABLE "races" ADD CONSTRAINT "fk_races_circuitId" FOREIGN KEY("circuitId")
REFERENCES "circuits" ("circuitId");

ALTER TABLE "results" ADD CONSTRAINT "fk_results_raceId" FOREIGN KEY("raceId")
REFERENCES "races" ("raceId");


~~~

---
### Jupyter Notebook File <a name="jnb"></a>
<sub><sup>[Go back to the table of contents](#toc)</sub></sup>
<br>

[![Jupyter Notebook](social_icons/clickherejn.png)](https://github.com/matheusgratz/etl-project/blob/main/f1_etc.ipynb)

---
### Answers <a name="ans"></a>

1. What's the distribution of drivers based on their nationality - TOP10?
<br>

**nationality**|**Count**
:-----:|:-----:
British|162
American|157
Italian|99
French|73
German|49
Brazilian|31
Argentine|24
South African|23
Belgian|23
Swiss|23

<br>
<br>
Based on the nationality:
<br>

2. What's the distribution of winners - TOP10?
<br>

**nationality**|**count**
:-----:|:-----:
British|267
German|173
Brazilian|101
French|79
Finnish|49
Italian|43
Austrian|41
Australian|40
Argentine|38
American|33

<br>
<br>

3. What's the distribution of 2nd places - TOP10?
<br>

**nationality**|**2nd**
:-----:|:-----:
British|195
German|117
French|111
Brazilian|103
Italian|79
Finnish|67
American|41
Austrian|40
Spanish|39
Australian|39

<br>
<br>
4. What's the distribution of 3rd places - TOP10?
<br>

**nationality**|**3nd**
:-----:|:-----:
British|186
French|113
German|102
Brazilian|89
Italian|85
Finnish|72
American|55
Australian|46
Austrian|37
New Zealander|36

<br>
<br>
5. What's the distribution of podium appearances - TOP10?
<br>

**nationality**|**1st**|**2nd**|**3rd**|**Total**
:-----:|:-----:|:-----:|:-----:|:-----:
British|267|195|186|648
German|173|117|102|392
French|79|111|113|303
Brazilian|101|103|89|293
Italian|43|79|85|207
Finnish|49|67|72|188
American|33|41|55|129
Australian|40|39|46|125
Austrian|41|40|37|118
Spanish|32|39|28|99