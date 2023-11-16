import matplotlib.pyplot as plt
import numpy as np

# Histograms for Flow shop model
idle_time = np.array([0,5+2+7+5+5+0+7,8+2+9+7+7+0+9,11+4+11+8+8+1+11,12])


plt.hist(idle_time)
plt.show()