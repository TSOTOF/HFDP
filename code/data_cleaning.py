# -*- coding: utf-8 -*-

import os
import pandas as pd
import datetime
import time
import re

'''
将'table_select.csv'文件置于数据集中，生成数据清洗的任务列表
'''

os.chdir() # 输入数据集地址


# file_list = os.listdir()
def datetime_trans(input_string):
    '''
    将形如"05JAN2015:13:51:35"转换为"2015/01/05 13:51:35"的形式
    '''
    # 使用正则表达式提取日期和时间信息
    match = re.match(r"(\d{2})([A-Za-z]{3})(\d{4}):(\d{2}):(\d{2}):(\d{2})", input_string)    

    day, month, year, hour, minute, second = match.groups()    

    months = {
        'JAN': '01', 'FEB': '02', 'MAR': '03', 'APR': '04',
        'MAY': '05', 'JUN': '06', 'JUL': '07', 'AUG': '08',
        'SEP': '09', 'OCT': '10', 'NOV': '11', 'DEC': '12'
    }
    
    return f"{year}/{months[month]}/{day} {hour}:{minute}:{second}"

def time_trans(input_string):
    '''
    形如'15:30'的字符串转换为15:30的datetime
    '''
    hour = int(input_string.split(':')[0])
    minute = int(input_string.split(':')[1])
    
    return datetime.time(hour,minute)

def data_cleaning(filename,_format,_type,freq,year,mkt,code,pure):
    '''
    - 通过读取下载信息表获取任务信息
        /*1.tablename   | 数据表代码*/ str
        /*2.libraryname | 逻辑库代码*/ str
        /*3.format      | 分时数据表(1)还是分笔数据表(0)*/ int
        /*4.pure        | 数据表内是否不再需要筛选品种,可以直接下载*/ int 
        /*5.type        | 数据表对应证券品种*/ str
        /*6.freq        | 数据表对应数据频率*/ int
        /*7.year        | 数据表对应数据年份*/ int
        /*8.mkt         | 数据表对应市场*/ str
        /*9.code        | 数据表对应证券代码*/ int

    '''
    try:
        data = pd.read_csv(filename,encoding='ANSI') # 数据统一ANSI编码
    except FileNotFoundError:
        return
    

    if _type == 'bond':
        # 债市连续匹配交易时间 9：30-11：30，13：30-15：30 
        tp1_start = datetime.time(9,30) # 交易时间段1开盘时间
        tp1_end = datetime.time(11,30) # 交易时间段1收盘时间    
        tp2_start = datetime.time(13,00) # 交易时间段2开盘时间
        tp2_end = datetime.time(15,30) # 交易时间段2收盘时间
    else:  
        # 沪深两市交易时间
        tp1_start = datetime.time(9,30) # 交易时间段1开盘时间
        tp1_end = datetime.time(11,30) # 交易时间段1收盘时间    
        tp2_start = datetime.time(13,00) # 交易时间段2开盘时间
        tp2_end = datetime.time(15,00) # 交易时间段2收盘时间
    
    
    data['QTime'] = data['QTime'].apply(datetime_trans) # 统一为%y/%m/%d %H:%M%S形式
    data['QTime'] = pd.to_datetime(data['QTime'],errors='coerce')
    
    # 判断时间是否在交易时间段内    
    if _format == 1:
        # 对于分时数据，Stdtime为交易时间
        data['Stdtime'] = data['Stdtime'].apply(time_trans)
        data = data[((data['Stdtime']<tp1_end) & (data['Stdtime']>tp1_start)) | ((data['Stdtime']<tp2_end) & (data['Stdtime']>tp2_start))]
    elif _format == 0:
        # 对于分笔数据，使用Qtime的时间作为其交易时间
        data['Trade_Time'] = data['QTime'].dt.time 
        data = data[((data['Trade_Time']<tp1_end) & (data['Trade_Time']>tp1_start)) | ((data['Trade_Time']<tp2_end) & (data['Trade_Time']>tp2_start))]
    
    if 'MTime' in data: 
        data = data.drop(labels=['MTime'],axis=1)
        
    data.to_csv(filename,encoding='ANSI',index=0)

def run(in_q,q_len):
    while len(in_q) != 0:
        info = in_q.pop()
        data_cleaning(filename = info[0] + '.csv',
                      _format = info[2],
                      pure = info[3],
                      _type = info[4],
                      freq = info[5],
                      year = info[6],
                      mkt = info[7],
                      code = info[8])
        print(f'\r数据已经清洗了{(1-len(in_q)/q_len)*100:>6.1f}%',end='')

        

if __name__ == '__main__':
    start = time.time()

    try:
        df_select = pd.read_csv('table_select.csv',encoding='utf-8')     
    except UnicodeDecodeError:
        df_select = pd.read_csv('table_select.csv',encoding='ANSI')
    
    queue_list = []
    for value in df_select.values:
        queue_list.append(value)
        
    q_len = len(os.listdir())-1
    run(queue_list,q_len)

    end = time.time()
    print(f"\n总耗时:{end-start}")

    



