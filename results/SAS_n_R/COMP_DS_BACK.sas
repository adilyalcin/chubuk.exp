PROC IMPORT OUT = WORK.Expdata 
            DATAFILE =
            "/folders/myfolders/COMP_DS_BACK.csv"
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2;
RUN;

data Expdata; set Expdata; LogTime = log(timing); run;

DATA just15;
    SET Expdata;
    IF (data_size = 75) THEN DELETE;
    IF (data_size = 150) THEN DELETE;
RUN;

PROC mixed data = Expdata;
    CLASS chart data_size workerId true_percentage;
    MODEL error = chart data_size chart*data_size;
	RANDOM intercept / SUBJECT= workerId;
    lsmeans chart / pdiff adjust = tukey;
    lsmeans data_size / pdiff adjust = tukey;
run;

