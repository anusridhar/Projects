import pandas as pd
import matplotlib.pyplot as plt

#with open('globaldata.csv', 'r') as csvfile:
    #plots= csv.reader(csvfile, delimiter=',')
    
df = pd.read_csv("yearlyavgtemp.csv") 

def movingAverage(windowRolling, df_in):
    df_out = df_in.rolling(window = windowRolling, center=False, on = "year").mean()
    return df_out
rollingWindow_size = 30

df_movingAverage = movingAverage(rollingWindow_size, df)

plt.plot(df_movingAverage['year'], df_movingAverage['city_avg_temp'], label='Boston')
plt.plot(df_movingAverage['year'], df_movingAverage['global_avg_temp'], label='Global')

plt.legend()
#plt.plot(x,y, marker='x')
plt.title('Boston Temperature Vs Global Temperature plotted with moving average')
plt.xlabel("Year")
plt.ylabel("Temperature")
plt.show()


