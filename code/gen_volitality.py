# -*- coding: utf-8 -*-
'''
计算已实现波动率
'''

import pandas as pd
from numpy import log

def gen_vol(filedir,how='daily'):
    '''
    Parameters
    ----------
    filedir : str
        File address
    how : str, optional
        The default is 'daily', 'daily', 'weekly' and 'monthly'

    '''
    df_data = pd.read_csv(filedir,encoding='ANSI')

    df_data['Trade_Time'] = df_data['Qdate'] + " " + df_data['Stdtime']
    df_data['Trade_Time'] = pd.to_datetime(df_data['Trade_Time'],errors='coerce')
    df_data = df_data.sort_values(by='Trade_Time')
    df_data['TPrice'] = df_data['TPrice'].fillna(method='ffill') # 遇到缺失值用上面相邻最近的的数据填充
    df_data['Diff_1'] = df_data['TPrice'].diff(1)
    df_data['Var'] = log(df_data['Diff_1']/df_data['TPrice']+1)**2
    if how == 'daily':
        vol_daily = (df_data.groupby(by='Qdate').Var.sum()*252)**0.5
        return vol_daily
    if how == 'weekly':
        df_data['week'] = df_data['Trade_Time'].dt.isocalendar().week
        vol_weekly = (df_data.groupby(by='week').Var.sum()*252/5)**0.5
        return vol_weekly
    if how == 'monthly':
        df_data['month'] = df_data['Trade_Time'].dt.month
        vol_monthly = (df_data.groupby(by='month').Var.sum()*252/21)**0.5
        return vol_monthly













