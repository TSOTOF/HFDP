/**********************************************************建立远程服务器连接并登录**********************************************************/
%let ressethf=202.204.172.144;
options comamid=TCP remote=ressethf;
signon ressethf username=resset password=resset;
/*********************************************************建立分笔高频数据远程逻辑库*********************************************************/ 
libname HF2005 'D:\HF2005' server=ressethf;
libname HF2006 'D:\HF2006' server=ressethf;
libname HF2007 'D:\HF2007' server=ressethf;
libname HF2008 'D:\HF2008' server=ressethf;
libname HF2009 'D:\HF2009' server=ressethf;
libname HF2010 'D:\HF2010' server=ressethf;
libname HF2011 'D:\HF2011' server=ressethf;
libname HF2012 'D:\HF2012' server=ressethf;
libname HF2013 'D:\HF2013' server=ressethf;
libname HF2014 'D:\HF2014' server=ressethf;
libname HF2015 'D:\HF2015' server=ressethf;
libname HF2016 'F:\HF2016' server=ressethf;
libname HF2017 'F:\HF2017' server=ressethf;
libname HF2018 'E:\HF2018' server=ressethf;
libname HF2019 'G:\HF2019' server=ressethf;
libname HF2020 'E:\HF2020' server=ressethf;
libname HF2021 'I:\HF2021' server=ressethf;
libname HF2022 'J:\HF2022' server=ressethf;
/*********************************************************建立分时高频数据远程逻辑库*********************************************************/ 
libname HF1999M 'J:\HF1999M' server=ressethf;
libname HF2000M 'J:\HF2000M' server=ressethf;
libname HF2001M 'J:\HF2001M' server=ressethf;
libname HF2002M 'J:\HF2002M' server=ressethf;
libname HF2003M 'J:\HF2003M' server=ressethf;
libname HF2004M 'J:\HF2004M' server=ressethf;
libname HF2005M 'J:\HF2005M' server=ressethf;
libname HF2006M 'J:\HF2006M' server=ressethf;
libname HF2007M 'J:\HF2007M' server=ressethf;
libname HF2008M 'J:\HF2008M' server=ressethf;
libname HF2009M 'J:\HF2009M' server=ressethf;
libname HF2010M 'J:\HF2010M' server=ressethf;
libname HF2011M 'J:\HF2011M' server=ressethf;
libname HF2012M 'J:\HF2012M' server=ressethf;
libname HF2013M 'J:\HF2013M' server=ressethf;
libname HF2014M 'J:\HF2014M' server=ressethf;
libname HF2015M 'J:\HF2015M' server=ressethf;
libname HF2016M 'J:\HF2016M' server=ressethf;
libname HF2017M 'J:\HF2017M' server=ressethf;
libname HF2018M 'K:\HF2018M' server=ressethf;
libname HF2019M 'K:\HF2019M' server=ressethf;
libname HF2020M 'K:\HF2020M' server=ressethf;
libname HF2021M 'K:\HF2021M' server=ressethf;
libname HF2022M 'K:\HF2022M' server=ressethf;
/**************************************************************下载数据表数据**************************************************************/

/*输出所有分笔数据表代码*/

proc sql;
    create table work.table2005_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2005';
quit;
proc export data = work.table2005_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2005.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2006_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2006';
quit;
proc export data = work.table2006_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2006.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2007_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2007';
quit;
proc export data = work.table2007_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2007.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2008_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2008';
quit;
proc export data = work.table2008_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2008.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2009_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2009';
quit;
proc export data = work.table2009_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2009.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2010_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2010';
quit;
proc export data = work.table2010_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2010.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2011_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2011';
quit;
proc export data = work.table2011_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2011.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2012_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2012';
quit;
proc export data = work.table2012_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2012.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2013_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2013';
quit;
proc export data = work.table2013_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2013.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2014_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2014';
quit;
proc export data = work.table2014_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2014.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2015_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2015';
quit;
proc export data = work.table2015_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2015.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2016_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2016';
quit;
proc export data = work.table2016_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2016.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2017_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2017';
quit;
proc export data = work.table2017_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2017.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2018_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2018';
quit;
proc export data = work.table2018_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2018.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2019_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2019';
quit;
proc export data = work.table2019_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2019.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2020_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2020';
quit;
proc export data = work.table2020_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2020.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2021_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2021';
quit;
proc export data = work.table2021_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2021.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2022_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2022';
quit;
proc export data = work.table2022_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2022.csv'
    dbms = csv replace;
run;
/*输出所有分时数据表代码*/

proc sql;
    create table work.table1999M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF1999M';
quit;
proc export data = work.table1999M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF1999M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2000M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2000M';
quit;
proc export data = work.table2000M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2000M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2001M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2001M';
quit;
proc export data = work.table2001M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2001M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2002M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2002M';
quit;
proc export data = work.table2002M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2002M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2003M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2003M';
quit;
proc export data = work.table2003M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2003M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2004M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2004M';
quit;
proc export data = work.table2004M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2004M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2005M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2005M';
quit;
proc export data = work.table2005M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2005M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2006M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2006M';
quit;
proc export data = work.table2006M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2006M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2007M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2007M';
quit;
proc export data = work.table2007M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2007M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2008M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2008M';
quit;
proc export data = work.table2008M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2008M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2009M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2009M';
quit;
proc export data = work.table2009M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2009M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2010M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2010M';
quit;
proc export data = work.table2010M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2010M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2011M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2011M';
quit;
proc export data = work.table2011M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2011M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2012M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2012M';
quit;
proc export data = work.table2012M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2012M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2013M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2013M';
quit;
proc export data = work.table2013M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2013M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2014M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2014M';
quit;
proc export data = work.table2014M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2014M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2015M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2015M';
quit;
proc export data = work.table2015M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2015M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2016M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2016M';
quit;
proc export data = work.table2016M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2016M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2017M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2017M';
quit;
proc export data = work.table2017M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2017M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2018M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2018M';
quit;
proc export data = work.table2018M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2018M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2019M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2019M';
quit;
proc export data = work.table2019M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2019M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2020M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2020M';
quit;
proc export data = work.table2020M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2020M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2021M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2021M';
quit;
proc export data = work.table2021M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2021M.csv'
    dbms = csv replace;
run;

proc sql;
    create table work.table2022M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF2022M';
quit;
proc export data = work.table2022M_list
    outfile = '../../数据代码列表/原始逻辑库代码/HF2022M.csv'
    dbms = csv replace;
run;
