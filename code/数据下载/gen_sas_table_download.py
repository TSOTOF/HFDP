# -*-coding:utf-8 -*-
import io
import os
import sys
import numpy as np
import pandas as pd
import datetime as dt
## 按条件筛选需要下载的数据
# 1.tablename   | 数据表代码
# 2.libraryname | 逻辑库代码
# 3.format      | 分时数据表(1)还是分笔数据表(0)
# 4.pure        | 数据表内是否不再需要筛选品种,可以直接下载
# 5.type        | 数据表对应证券品种('stk','bond','indx','fund')
# 6.freq        | 数据表对应数据频率(np.nan,1,5,10,15,20,30,40,60)
# 7.year        | 数据表对应数据年份(分笔:1999-2022;分时:2005-2022)
# 8.mkt         | 数据表对应市场('sz','sh')
# 9.code        | 数据表对应证券代码
## 共6个条件,条件筛选完后要看下最终会生成多少个csv文件,如果csv文件超过3万个还需要手动在sas界面点击继续
format = [1] #[0,1]
pure = [0,1] #[0,1]
type = ['mix','stk'] #['mix','stk','bond','indx','fund']
freq = [10] #[0,1,5,10,15,20,30,40,60]
year = list(range(2007,2022)) #list(range(1999,2022))
mkt = ['mix','sz','sh'] #['mix','sz','sh']
df_code = pd.read_csv('../../数据代码列表/全部数据表信息.csv',dtype = {'code': str})
df_code_select = df_code[np.isin(df_code['format'],format)*np.isin(df_code['pure'],pure)\
                         *np.isin(df_code['type'],type)*np.isin(df_code['freq'],freq)\
                         *np.isin(df_code['year'],year)*np.isin(df_code['mkt'],mkt)]
df_code_select.reset_index(drop = True,inplace = True)
# 按照当前日期和时间新建文件夹并命名
now = dt.datetime.strftime(dt.datetime.now(),format = '%Y-%m-%d-%H-%M')
path = "F:/{}".format(now)
os.makedirs(path)
df_code_select.to_csv('{}/table_select.csv'.format(path),index = False)
## 生成下载数据的sas代码
sys.stdout=io.TextIOWrapper(sys.stdout.buffer,encoding='utf8') #改变标准输出的默认编码
data = open("{}/table_download.txt".format(path),'w+')
# start是下载数据的登录和连接代码
start = '''/**********************************************************建立远程服务器连接并登录**********************************************************/
%let ressethf=202.204.172.144;
options comamid=TCP remote=ressethf;
options nonotes nosource nosource2 errors=0;
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
'''
path_data = path + '/数据'
os.makedirs(path_data)
print(start,file = data)
for i in range(len(df_code_select)):
    libraryname = df_code_select.iloc[i,1]
    tablename = df_code_select.iloc[i,0]
    str = '''
proc export
data = {}.{}
outfile = "数据/{}.csv"
dbms = csv
replace;
run;'''.format(libraryname,tablename,tablename)
    print(str,file = data)
data.close()