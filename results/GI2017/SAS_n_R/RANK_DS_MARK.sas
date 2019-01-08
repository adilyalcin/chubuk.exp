PROC IMPORT OUT = WORK.Expdata 
            DATAFILE =
            "/folders/myfolders/RANK_DS_MARK.csv"
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2;
RUN;

data Expdata; set Expdata; LogTime = log(timing); run;

PROC mixed data = Expdata;
    class chart data_size workerId;
    model error = chart data_size chart*data_size;
    random intercept / sub = workerId;
    lsmeans chart / pdiff adjust = tukey;
    lsmeans data_size / pdiff adjust = tukey;
    lsmeans chart * data_size / pdiff adjust = tukey;
run;