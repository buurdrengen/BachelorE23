## Aksel - flowshop work
import pandas as pd
import numpy as np 
from itertools import permutations
import math

# Defining the 2 products with time at the 5 stations. 
p1 = np.array([5, 3, 3, 1, 10])
p2 = np.array([10, 5, 3, 2, 10])

total_jobs = np.concatenate([np.tile(p2,(40,1)),np.tile(p1,(30,1))])
print(total_jobs)

total_completion_time = total_jobs.sum(axis=1)
print(total_completion_time)

best_order = np.array([])

n = total_completion_time.shape[0]


def create_permutations(list_jobs, job):
        " Create permutations"
        " [1,2], 3 -> [3,1,2], [1,3,2], [1,2,3]"
        " Input list_jobs and job"
        " list_jobs: A list of the jobs to make permutations of "
        " job: The job that is inserted into the list_jobs "
        " Output list_permutations "

        list_permutations = np.array([])

        for i in range(0,len(list_jobs) + 1):
            #print(i)
            perm = np.copy(list_jobs)
            #print(perm)
            perm = np.insert(perm, i, job)
            list_permutations = np.append(list_permutations,perm)
            #print(list_permutations)
        return list_permutations

#print(create_permutations(np.array([1,2]),3))

#def compute_makespan()

#print(np.size(create_permutations(total_completion_time,1)))
