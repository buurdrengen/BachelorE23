## Aksel - flowshop work
import pandas as pd
import numpy as np 
from itertools import permutations

# Defining the 2 products with time at the 5 stations. 
p1 = np.array([5, 3, 3, 1, 10])
p2 = np.array([10, 5, 3, 2, 10])

total_jobs = np.concatenate([np.tile(p2,(40,1)),np.tile(p1,(30,1))])
print(total_jobs)

total_completion_time = total_jobs.sum(axis=1)
print(total_completion_time)

best_order = np.array([])

n = total_completion_time.shape[0]
a = range(0,70+1)
print(a)

print(np.arange(0,len(p1)+1))

def create_permutations(list_jobs, job):
   " Create permutations "
   list_permutations = np.array([])

   for i in range(0,len(list_jobs) + 1):
        print(i)
        perm = np.copy(list_jobs)
        print(perm)
        perm = np.insert(perm, i, job)
        print(perm)
        list_permutations = np.append(list_permutations,perm)
        return list_permutations

print(create_permutations(np.array([1,2]),3))


b = np.array([1,2,3])
c = np.copy(b)
print(c)
