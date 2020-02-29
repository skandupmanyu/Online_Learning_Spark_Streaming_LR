
import pandas as pd
import numpy as np
import time
import plotille
import pymysql
import subprocess as sp


while(True):
    conn = pymysql.connect(
    host='localhost',
    port=int(3306),
    user="root",
    passwd='password',
    db="ONLINE_LEARNING_DB",
    charset='utf8mb4')

    coefficients = pd.read_sql_query("SELECT * FROM coefficients", conn)

    training_data = pd.read_sql_query("SELECT * FROM training_data", conn)
    last_10_points = training_data.iloc[-10:, :]

    conn.close()
    
    if(coefficients.shape[0] > 0 and training_data.shape[0] > 0):
        # Plot
        fig = plotille.Figure()
        fig.width = 50
        fig.height = 25
        fig.origin = False
        fig.set_x_limits(min_=0, max_=100)
        fig.set_y_limits(min_=-200, max_=200)
        fig.color_mode = 'byte'
        beta0 = coefficients.tail(1)['BETA0'].values[0]
        beta1 = coefficients.tail(1)['BETA1'].values[0]
        lin_reg_x = np.linspace(min(training_data['X1']),max(training_data['X1']),100)
        lin_reg_y = beta0 + lin_reg_x*beta1
        fig.scatter(training_data['X1'], training_data['Y'], lc=25, label='training_data')
        # fig.scatter(last_10_points['X1'], last_10_points['Y'], lc=1, label='last 10 points')
        fig.plot(lin_reg_x, lin_reg_y, lc=100, label='regression line')
        _ = sp.call('clear',shell=True)
        print(fig.show(legend=True))       
        time.sleep(5)
        _ = sp.call('clear',shell=True)
    else:
        print('Waiting for data...')
        time.sleep(5)

