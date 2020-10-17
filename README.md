# F1 ETL Process
## Contributors
* Matheus Gratz - matheusgratz@gmail.com [![GitHub](social_icons/gthb.png)](https://github.com/matheusgratz/)  [![Linkedin](social_icons/lkdin.png)](https://www.linkedin.com/in/matheusgratz/) [![Twiter](social_icons/twtr.png)](https://twitter.com/matheusgratz)  
* Sergio Guarneros - sergioguarneros95@gmail.com [![GitHub](social_icons/gthb.png)](https://github.com/SergioGL8/)  [![Linkedin](social_icons/lkdin.png)](https://www.linkedin.com/in/sergio-guarneros-luna-1990/) [![Twiter](social_icons/twtr.png)](https://twitter.com/zerchluna)  
* Roberto Gonzalez - roberto.gonzalez.vallejo@gmail.com [![GitHub](social_icons/gthb.png)](https://github.com/roberto-g-v/)  [![Linkedin](social_icons/lkdin.png)](https://www.linkedin.com/in/roberto-gonzalez-vallejo-6ba894144/) [![Twiter](social_icons/twtr.png)](https://twitter.com/RobertoGlezV)  

---
Table of contents <a name="toc"></a>

1. [ERD](#erd)
2. [postgreSQL Statatements](#psql)
3. [Jupyter Notebook File](#jnb)

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