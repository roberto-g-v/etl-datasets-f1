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

