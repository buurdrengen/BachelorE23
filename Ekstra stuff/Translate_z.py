
## Translate z
    
import numpy as np 
  
z_opt = np.loadtxt("z_file.txt", skiprows=4) 
print(z_opt)

location = [(i, j) for j in range(z_opt.shape[0]) for i in range(z_opt.shape[1]) if z_opt[i, j] > 0.5]
location = np.transpose(location)
location = location[0,:]
print(location)

name = []
for i in location:
    #print(i)
    if 0 <= i <= 2:
        name.append('1D')
    elif 3 <= i <= 7:
        name.append('2D')
    
print(name)




