# -*-coding:utf-8 -*-
import io
import sys
import numpy as np
sys.stdout=io.TextIOWrapper(sys.stdout.buffer,encoding='utf8') #改变标准输出的默认编码
flag = 1 #flag = 0输出分笔代码,flag = 1输出分时代码
if flag == 0: 
    lst = np.arange(2005,2023)
    for y in lst:
        str = \
'''libname HF{} 'D:\HF{}' server=ressethf;
proc sql;
    create table work.table{}_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF{}';
quit;
proc export data = work.table{}_list
    outfile = '../数据代码列表/HF{}.csv'
    dbms = csv replace;
run;'''.format(y,y,y,y,y,y)
        print(str)
else:
    lst = np.arange(1999,2023)
    for y in lst:
        str = \
'''libname HF{}M 'J:\HF{}M' server=ressethf;
proc sql;
    create table work.table{}M_list as
    select memname as table_name
    from dictionary.tables
    where libname = 'HF{}M';
quit;
proc export data = work.table{}M_list
    outfile = '../数据代码列表/HF{}M.csv'
    dbms = csv replace;
run;'''.format(y,y,y,y,y,y)
        print(str)