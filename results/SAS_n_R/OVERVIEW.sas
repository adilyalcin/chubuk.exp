PROC IMPORT OUT = WORK.Expdata 
            DATAFILE =
            "/folders/myfolders/VIEW.csv"
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2;
RUN;

data Expdata; set Expdata; LogTime = log(timing); run;

proc glimmix;
    class chart workerId data_size;
    model outcome_true = chart data_size chart*data_size / dist=BINARY ddfm=KR;
    lsmeans chart / adjust=tukey lines ilink;
    random intercept / type=CS residual subject=workerId;
run;