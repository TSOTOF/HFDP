# -*- coding: utf-8 -*-

import os
import pandas as pd
import datetime
# os.chdir()
# file_list = os.listdir()

def data_cleaning(filename):
    try:
        data = pd.read_csv(filename,encoding='utf-8') # 编码统一utf-8       
    except UnicodeDecodeError:
        data = pd.read_csv(filename,encoding='ANSI') # 好像有ANSI编码的数据
        
    # 所有命名规则中，第一个"_"之前的两个字符为年份
    year = int(filename[filename.find('_')-2:filename.find('_')])
    if year > 90:
        year = 1900 + year
    else: 
        year = 2000 + year

    # 沪深两市交易时间为例，后续会拓展
    tp1_start = datetime.time(9,30) # 交易时间段1开盘时间
    tp1_end = datetime.time(11,30) # 交易时间段1收盘时间    
    tp2_start = datetime.time(13,00) # 交易时间段2开盘时间
    tp2_end = datetime.time(15,00) # 交易时间段2收盘时间
    
    if year <= 2018:
        # 下载数据时，时间能否统一成标准时间？ 即%y/%m/%d %H:%M%S形式
        data['QTime'] = pd.to_datetime(data['QTime'],errors='coerce')
        # 判断时间是否在交易时间段内
        data['Trade_Time'] = data['QTime'].dt.time 
        data.drop(labels=['MTime'],axis=1)
        data = data[((data['Trade_Time']<tp1_end) & (data['Trade_Time']>tp1_start)) | ((data['Trade_Time']<tp2_end) & (data['Trade_Time']>tp2_start))]
    elif year >= 2019:
        data['QTime'] = pd.to_datetime(data['QTime'],errors='coerce')
        data['Trade_Time'] = data['QTime'].dt.time 
        data = data[((data['Trade_Time']<tp1_end) & (data['Trade_Time']>tp1_start)) | ((data['Trade_Time']<tp2_end) & (data['Trade_Time']>tp2_start))]
    else:
        return None
    
    return data





    



