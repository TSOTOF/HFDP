import pandas as pd
import numpy as np
import os
df_table = pd.DataFrame(np.full([1,9],np.nan)) #分时逻辑库数据表代码
# tablename   | 数据表名称
# libraryname | 逻辑库名称
# format      | 分时数据表(1)还是分笔数据表(0)
# pure        | 数据表内是否不再需要筛选品种,可以直接下载
# type        | 数据表对应证券品种
# freq        | 数据表对应数据频率
# year        | 数据表对应数据年份
# mkt         | 数据表对应市场
# code        | 数据表对应证券代码
df_table.columns = ['tablename','libraryname','format','pure','type','freq','year','mkt','code']
## 建立逻辑库表格
df_filename = pd.DataFrame(os.listdir('../../数据代码列表/原始逻辑库代码'))
df_filename.columns = ['filename']
## 通过逻辑库的format和year两个参数判断数据表代码格式
df_filename['libraryname'] = df_filename['filename'].apply(lambda x:x[:-4]) #逻辑库名称
df_filename['format'] = df_filename['filename'].apply(lambda x:1 if ('M' in x) else 0) #逻辑库是分时(1)还是分比(0)
df_filename['year'] = df_filename['filename'].apply(lambda x:int(x[2:6])) #逻辑库对应年份
## 从数据表代码中提取有效信息
def info(x,libraryname,format,year): 
    if format == 1 and year <= 2011: #分时逻辑库1999-2011年
        pure,type,code = 0,np.nan,np.nan
        tablename = x.iloc[0]
        freq = int(tablename.split('_')[1])
        mkt = tablename[:2].lower()
        return tablename,libraryname,format,pure,type,freq,year,mkt,code
    elif format == 1 and year >= 2012: #分时逻辑库2012-2022年
        pure = 1
        splitstr = 'HF' + str(year) + '_'
        tablename = x.iloc[0]
        if 'hf' in tablename.lower(): #有些乱七八糟的数据表不用管
            type = tablename.split(splitstr)[0].lower()
            freq = int(tablename.split(splitstr)[1].split('_')[1])
            mkt = tablename.split(splitstr)[1].split('_')[0][-2:].lower()
            code = tablename.split(splitstr)[1].split('_')[0][:-2]
            return tablename,libraryname,format,pure,type,freq,year,mkt,code
        else:
            return np.nan,np.nan,np.nan,np.nan,np.nan,np.nan,np.nan,np.nan,np.nan
    elif format == 0 and year <= 2009: #分笔逻辑库2005-2009年
        pure,freq,mkt = 1,np.nan,np.nan
        splitstr = str(year)[2:] + '_'
        tablename = x.iloc[0]
        type = tablename.split(splitstr)[0].lower()
        code = tablename.split(splitstr)[1]
        return tablename,libraryname,format,pure,type,freq,year,mkt,code
    elif format == 0 and year >= 2010 and year <= 2011: #分笔逻辑库2010-2011年
        pure,freq,mkt = 1,np.nan,np.nan
        splitstr = str(year) + '_'
        tablename = x.iloc[0]
        type = tablename.split(splitstr)[0].lower()
        try:
            code = tablename.split(splitstr)[1]
        except:
            code = tablename.split(splitstr)[1][:-2]
        return tablename,libraryname,format,pure,type,freq,year,mkt,code
    elif format == 0 and year >= 2012: #分笔逻辑库2012-2022年
        pure,freq = 1,np.nan
        splitstr = 'HF' + str(year) + '_'
        tablename = x.iloc[0]
        if 'hf' in tablename.lower(): #有些乱七八糟的数据表不用管
            type = tablename.split(splitstr)[0].lower()
            mkt = tablename.split(splitstr)[1][-2:].lower()
            code = tablename.split(splitstr)[1][:-2]
            return tablename,libraryname,format,pure,type,freq,year,mkt,code
        else:
            return np.nan,np.nan,np.nan,np.nan,np.nan,np.nan,np.nan,np.nan,np.nan
## 循环全部42个逻辑库，提取逻辑库中的全部数据表信息
for i in range(len(df_filename)): 
    df_ = pd.read_csv('../../数据代码列表/原始逻辑库代码/{}'.format(df_filename['filename'][i]))
    libraryname = df_filename['libraryname'][i]
    format = df_filename['format'][i]
    year = df_filename['year'][i]
    table_ = pd.DataFrame(df_.apply(info,args = (libraryname,format,year),axis = 1,result_type="expand"))
    table_.columns = ['tablename','libraryname','format','pure','type','freq','year','mkt','code']
    df_table = pd.concat([df_table,table_])
df_table.dropna(how = 'all',inplace = True) #删除无效数据，即全为空值的行
df_table.to_csv('../../数据代码列表/全部数据表信息.csv',index = False)