# -*- coding: utf-8 -*-

import pandas as pd
def gen_OIB(data,mkt_value):
    '''
    data: DataFrame
    使用清洗后的高频交易数据生成日度的OIB
    股票流通盘市值需要另外给出
    '''
    data = data.sort_values(by='QTime')
    mid = (data['Bidpr1'] + data['Askpr1'])/2
    buy = data[data['TPrice']>mid]['TSum'].sum() # 主动买入成交额
    sell = data[data['TPrice']<mid]['TSum'].sum()
    
    temp = data[data['TPrice']==mid][['TSum','QTime']]
    return temp
    for i in range(len(temp.index)):
        if i == 0:
            continue
        if temp.loc[temp.index[i],'QTime'] > temp.loc[temp.index[i-1],'QTime']:
            buy += temp.loc[temp.index[i],'TSum']
        else:
            sell += temp.loc[temp.index[i],'TSum']
    OIB = (buy - sell)/mkt_value
    return OIB