%let ressethf=202.204.172.144; 
options comamid=TCP remote=ressethf; 
signon ressethf username=resset password=resset;

/*以下代码将建立分笔高频数据远程逻辑库*/ 
/*libname HF2005 'D:\HF2005' server=ressethf; */
/*libname HF2006 'D:\HF2006' server=ressethf; */
/*libname HF2007 'D:\HF2007' server=ressethf; */
/*libname HF2008 'D:\HF2008' server=ressethf; */
/*libname HF2009 'D:\HF2009' server=ressethf; */
/*libname HF2010 'D:\HF2010' server=ressethf; */
/*libname HF2011 'D:\HF2011' server=ressethf; */
/*libname HF2012 'D:\HF2012' server=ressethf; */
/*libname HF2013 'D:\HF2013' server=ressethf; */
/*libname HF2014 'D:\HF2014' server=ressethf; */
/*libname HF2015 'D:\HF2015' server=ressethf; */
libname HF2016 'F:\HF2016' server=ressethf; 
/*libname HF2017 'F:\HF2017' server=ressethf; */
/*libname HF2018 'E:\HF2018' server=ressethf; */
/*libname HF2019 'G:\HF2019' server=ressethf; */
/*libname HF2020 'E:\HF2020' server=ressethf; */
/*libname HF2021 'I:\HF2021' server=ressethf; */
/*libname HF2022 'J:\HF2022' server=ressethf; */

/*以下代码将建立分时高频数据远程逻辑库*/ 
/*libname HF1999M 'J:\HF1999M' server=ressethf; */
/*libname HF2000M 'J:\HF2000M' server=ressethf; */
/*libname HF2001M 'J:\HF2001M' server=ressethf; */
/*libname HF2002M 'J:\HF2002M' server=ressethf; */
/*libname HF2003M 'J:\HF2003M' server=ressethf; */
/*libname HF2004M 'J:\HF2004M' server=ressethf; */
/*libname HF2005M 'J:\HF2005M' server=ressethf; */
/*libname HF2006M 'J:\HF2006M' server=ressethf; */
/*libname HF2007M 'J:\HF2007M' server=ressethf; */
/*libname HF2008M 'J:\HF2008M' server=ressethf; */
/*libname HF2009M 'J:\HF2009M' server=ressethf; */
/*libname HF2010M 'J:\HF2010M' server=ressethf; */
/*libname HF2011M 'J:\HF2011M' server=ressethf; */
/*libname HF2012M 'J:\HF2012M' server=ressethf; */
/*libname HF2013M 'J:\HF2013M' server=ressethf; */
/*libname HF2014M 'J:\HF2014M' server=ressethf; */
/*libname HF2015M 'J:\HF2015M' server=ressethf; */
libname HF2016M 'J:\HF2016M' server=ressethf; 
/*libname HF2017M 'J:\HF2017M' server=ressethf; */
/*libname HF2018M 'K:\HF2018M' server=ressethf; */
/*libname HF2019M 'K:\HF2019M' server=ressethf; */
/*libname HF2020M 'K:\HF2020M' server=ressethf; */
/*libname HF2021M 'K:\HF2021M' server=ressethf; */
/*libname HF2022M 'K:\HF2022M' server=ressethf;*/

data a;
set HF2016.StkHF2016_600000SH; 
where qdate >= '03Aug2016'd and qdate <= '23Aug2016'd;
run;

proc export data = a                  
          outfile = 'E:/学习资料/temp/高频数据下载/数据下载/out.csv' 
          dbms = csv
          replace;
run;

signoff;
