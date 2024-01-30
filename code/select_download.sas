/**********************************************************����Զ�̷��������Ӳ���¼**********************************************************/
%let ressethf=202.204.172.144; 
options comamid=TCP remote=ressethf; 
signon ressethf username=resset password=resset;

/*********************************************************�����ֱʸ�Ƶ����Զ���߼���*********************************************************/ 
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

/*********************************************************������ʱ��Ƶ����Զ���߼���*********************************************************/ 
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

/**************************************************************��ȡ���ݱ����**************************************************************/
data tablelst;
/* �����㹻��ļ�¼���Ⱥ�dsdѡ�� */
infile '../���ݴ����б�/ȫ�����ݱ���Ϣ.csv' delimiter=',' dsd lrecl=500; 
/*���ݱ����tablenameһ��ܳ���Ĭ��str����Ϊ8����Ҫָ������ĳ���*/
informat tablename $ 40.;
informat libraryname $ 20.;
input tablename$ libraryname$ format pure type$ freq year mkt$ code$;
/*����ԭ���ݵ�һ�е�����*/
if _n_=1 then delete;
/*1.tablename   | ���ݱ����*/
/*2.libraryname | �߼������*/
/*3.format      | ��ʱ���ݱ�(1)���Ƿֱ����ݱ�(0)*/
/*4.pure        | ���ݱ����Ƿ�����ҪɸѡƷ��,����ֱ������*/
/*5.type        | ���ݱ��Ӧ֤ȯƷ��*/
/*6.freq        | ���ݱ��Ӧ����Ƶ��*/
/*7.year        | ���ݱ��Ӧ�������*/
/*8.mkt         | ���ݱ��Ӧ�г�*/
/*9.code        | ���ݱ��Ӧ֤ȯ����*/
run;

/**************************************************************ɸѡ���ݱ����**************************************************************/
data table_select;
	set tablelst;
	/* �����ַ������� */
	array char_array[*] _character_ tablename libraryname type mkt code;
	/* ������ֵ������ */
	array num_array[*] _numeric_ format pure freq year;
	/*�÷�ʱ���ݱ�*/
	if num_array[1] = 1 and
		/*ֻ����ѡȡ��4��Ʒ�� findw(char_array[3],'stk') + findw(char_array[3],'bond') + findw(char_array[3],'indx') + findw(char_array[3],'fund')*/
		/*ֻ����ծȯ����*/
/*		   findw(char_array[3],'bond') > 0 and*/
		/*ֻ����60���Ӽ�����*/
/*		   num_array[3] = 60 and*/
		/*ֻ����2015�������*/
		   num_array[4] = 2010 and
		/*ֻ�������������*/
		   char_array[4] = 'sz'
	then do;
	   output;
	end;
run;

proc export
	data = WORK.TABLE_SELECT
	outfile = "../���ݴ����б�/table_select.csv"
	dbms = csv 
	replace;
run;


/**************************************************************�������ݱ�����**************************************************************/
/*%macro download(libname, tablename);*/
/*	proc export*/
/*		data = &libname..&tablename */
/*		outfile = "../ԭʼ����/&tablename.csv"*/
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
/*    export_filepath = cats("../ԭʼ����/","&table_name",".csv");*/
/*	call symput('export_file_path', export_filepath);*/
/*/*	%let export_file_path = export_filepath;*/*/
/*	put tablename;*/
/*	data output;*/
/*	set &library_name..&table_name;*/
/*	file "&export_file_path" dlm=',';*/
/*	put (_all_) (+0);*/
/*	run;*/
/*run;*/

