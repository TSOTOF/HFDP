# HFDP
下载和处理Resset高频数据(High Frequency Data Processing)
图书馆网站:http://lib.uibe.edu.cn/zy/sjk/zwsjk/8f6862d0b32d4803b8f7653b06ea27a6.htm
sas下载安装参考:https://mp.weixin.qq.com/s/FVQ7rqdGNDtaZEclk6Askg
## 数据下载流程:
1.权衡分比和分时数据量，分比数据量过大，先用sas下载分时数据，共4个品种(股票，债券，指数，基金)
2.加载全部高频数据的sas逻辑库，提取全部高频数据表代码(数据代码列表)，方便后续下载
3.对数据代码列表初步处理，梳理数据表结构，生成新的数据表目录
4.去除无用变量，准备下载数据
## 数据处理流程
