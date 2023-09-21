## Aksel - flowshop work
import pandas as pd
import numpy as np 
from itertools import permutations

# Defining the 2 products with time at the 5 stations. 
p1 = np.array([5, 3, 3, 1, 10])
p2 = np.array([10, 5, 3, 2, 10])

total_jobs = np.concatenate([np.tile(p1,(30,1)),np.tile(p2,(40,1))])
print(total_jobs)

total_completion_time = total_jobs.sum(axis=1)
print(total_completion_time)

best_order = np.array([])
jobs_list = np.arange(1,71)
perm = list(permutations(jobs_list))
