/**********************************************************建立远程服务器连接并登录**********************************************************/
%let ressethf=202.204.172.144; 
options comamid=TCP remote=ressethf; 
signon ressethf username=resset password=resset;

/*********************************************************建立分笔高频数据远程逻辑库*********************************************************/ 
/*libname HF2005 'D:\HF2005' server=ressethf;*/
/*libname HF2006 'D:\HF2006' server=ressethf;*/
/*libname HF2007 'D:\HF2007' server=ressethf;*/
/*libname HF2008 'D:\HF2008' server=ressethf;*/
/*libname HF2009 'D:\HF2009' server=ressethf;*/
/*libname HF2010 'D:\HF2010' server=ressethf;*/
/*libname HF2011 'D:\HF2011' server=ressethf;*/
/*libname HF2012 'D:\HF2012' server=ressethf;*/
/*libname HF2013 'D:\HF2013' server=ressethf;*/
/*libname HF2014 'D:\HF2014' server=ressethf;*/
/*libname HF2015 'D:\HF2015' server=ressethf;*/
/*libname HF2016 'F:\HF2016' server=ressethf;*/
/*libname HF2017 'F:\HF2017' server=ressethf;*/
/*libname HF2018 'E:\HF2018' server=ressethf;*/
/*libname HF2019 'G:\HF2019' server=ressethf;*/
/*libname HF2020 'E:\HF2020' server=ressethf;*/
/*libname HF2021 'I:\HF2021' server=ressethf;*/
/*libname HF2022 'J:\HF2022' server=ressethf;*/

/*********************************************************建立分时高频数据远程逻辑库*********************************************************/ 
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
libname HF2010M 'J:\HF2010M' server=ressethf; 
/*libname HF2011M 'J:\HF2011M' server=ressethf; */
/*libname HF2012M 'J:\HF2012M' server=ressethf; */
/*libname HF2013M 'J:\HF2013M' server=ressethf; */
/*libname HF2014M 'J:\HF2014M' server=ressethf; */
/*libname HF2015M 'J:\HF2015M' server=ressethf; */
/*libname HF2016M 'J:\HF2016M' server=ressethf; */
/*libname HF2017M 'J:\HF2017M' server=ressethf; */
/*libname HF2018M 'K:\HF2018M' server=ressethf; */
/*libname HF2019M 'K:\HF2019M' server=ressethf; */
/*libname HF2020M 'K:\HF2020M' server=ressethf; */
/*libname HF2021M 'K:\HF2021M' server=ressethf; */
/*libname HF2022M 'K:\HF2022M' server=ressethf;*/

/**************************************************************读取数据表代码**************************************************************/
data tablelst;
/* 设置足够大的记录长度和dsd选项 */
infile '../数据代码列表/全部数据表信息.csv' delimiter=',' dsd lrecl=500; 
/*数据表代码tablename一般很长，默认str长度为8，需要指定更大的长度*/
informat tablename $ 40.;
informat libraryname $ 20.;
input tablename$ libraryname$ format pure type$ freq year mkt$ code$;
/*忽略原数据第一行的列名*/
if _n_=1 then delete;
/*1.tablename   | 数据表代码*/
/*2.libraryname | 逻辑库代码*/
/*3.format      | 分时数据表(1)还是分笔数据表(0)*/
/*4.pure        | 数据表内是否不再需要筛选品种,可以直接下载*/
/*5.type        | 数据表对应证券品种*/
/*6.freq        | 数据表对应数据频率*/
/*7.year        | 数据表对应数据年份*/
/*8.mkt         | 数据表对应市场*/
/*9.code        | 数据表对应证券代码*/
run;

/**************************************************************筛选数据表代码**************************************************************/
data table_select;
	set tablelst;
	/* 声明字符型数组 */
	array char_array[*] _character_ tablename libraryname type mkt code;
	/* 声明数值型数组 */
	array num_array[*] _numeric_ format pure freq year;
	/*用分时数据表*/
	if num_array[1] = 1 and
		/*只下载选取的4个品种 findw(char_array[3],'stk') + findw(char_array[3],'bond') + findw(char_array[3],'indx') + findw(char_array[3],'fund')*/
		/*只下载债券数据*/
/*		   findw(char_array[3],'bond') > 0 and*/
		/*只下载60分钟级数据*/
/*		   num_array[3] = 60 and*/
		/*只下载2015年的数据*/
		   num_array[4] = 2010 and
		/*只下载深交所的数据*/
		   char_array[4] = 'sz'
	then do;
	   output;
	end;
run;

proc export
	data = WORK.TABLE_SELECT
	outfile = "../数据代码列表/table_select.csv"
	dbms = csv 
	replace;
run;


/**************************************************************下载数据表数据**************************************************************/
/*%macro download(libname, tablename);*/
/*	proc export*/
/*		data = &libname..&tablename */
/*		outfile = "../原始数据/&tablename.csv"*/
/*		dbms = csv */
/*		replace;*/
/*	run;*/
/*%mend;*/
/**/
/*data download;*/
/*	set table_select;*/
/*	%macro downloads;*/
/*	%download(libraryname, tablename);*/
/*	%mend;*/
/*	%downloads;*/
/*run;*/
/**/
/*data download;*/
/*    set table_select;*/
/*/*	%let library_name = libraryname;*/*/
/*/*	%let table_name = tablename;*/*/
/*	call symput('library_name', libraryname);*/
/*	call symput('table_name', tablename);*/
/*    export_filepath = cats("../原始数据/","&table_name",".csv");*/
/*	call symput('export_file_path', export_filepath);*/
/*/*	%let export_file_path = export_filepath;*/*/
/*	put tablename;*/
/*	data output;*/
/*	set &library_name..&table_name;*/
/*	file "&export_file_path" dlm=',';*/
/*	put (_all_) (+0);*/
/*	run;*/
/*run;*/

