import pandas as pd
import numpy as np
import time
import plotille
import pymysql
import subprocess as sp

with open("../../config.txt") as f:
  for line in f:
    if line.startswith("MYSQL_USER"):
      mysql_user = line.split("=")[1].strip()
    elif line.startswith("MYSQL_PWD"):
      mysql_pwd = line.split("=")[1].strip()
    else:
      continue

while(True):

    conn = pymysql.connect(
    host='localhost',
    port=int(3306),
    user=mysql_user,
    passwd=mysql_pwd,
    db="ONLINE_LEARNING_DB",
    charset='utf8mb4')

    predictions = pd.read_sql_query("SELECT * FROM predictions", conn)
    last_10_predictions = predictions.iloc[-10:, :]

    conn.close()

    if(predictions.shape[0] > 0):
        max_ = 200
        min_ = -200
        fig = plotille.Figure()
        fig.width = 50
        fig.height = 25
        fig.origin = False
        fig.set_x_limits(min_=min_, max_=max_)
        fig.set_y_limits(min_=min_, max_=max_)
        fig.color_mode = 'byte'
        y_x = np.linspace(min_,max_,100)
        fig.scatter(predictions['Y'], predictions['PRED'], lc=100, label='predictions vs actuals')
        # fig.scatter(last_10_predictions['Y'], last_10_predictions['PRED'], lc=200, label='last 10 predictions')
        fig.plot(y_x, y_x, lc=50, label='line y = x (reference)')
        _ = sp.call('clear',shell=True)
        print(fig.show(legend=True))
        time.sleep(5)
        _ = sp.call('clear',shell=True)
    else:
        print('Waiting for data...')
        time.sleep(5)