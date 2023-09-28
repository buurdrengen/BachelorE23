## Aksel - flowshop work
import numpy as np 
from itertools import permutations
import time 

p1 = np.array([5, 3, 3, 1, 10])                                                 # Days for each station (step)
p2 = np.array([10, 5, 3, 2, 10])

no_p1 = 3                                                                       # 1D reflection
no_p2 = 4                                                                       # 2D reflection (wolter)

all_jobs = np.concatenate([np.tile(p1,(no_p1,1)),np.tile(p2,(no_p2,1))])        # Colleting all products in one array

def solve_problem(total_jobs):
        # Describtion 
        start = time.time()                                                     # Starting timewatch
        joblist = np.arange(0,len(total_jobs))                                  # Index of all products
        permutation = list(permutations(joblist))                               # All combinations for index
        c_max = np.inf                                                          # Number of days can go to infinity, making it possible for the loop to go on
        best_order = np.array([])                                               # Empty array for optimal combination
        for i in permutation:                                                   # Starting loop for every index in each combination
            current_c_max = compute_makespan(total_jobs, i)                     # Computing makespan in each combination
            if current_c_max < c_max:                                           # If the makespan in the current combination is better than the last optimal combination
                c_max = current_c_max                                           # The optimal number of days is overwritten with current makespan
                best_order = i                                                  # Saving optimal combination
                print(c_max, best_order)                                        # Printing optimal number of days and combination 
            #elif current_c_max = c_max:
        c_max = c_max + 60                                                      # Adding step 0 (activations days)
        end = time.time()                                                       # Stopping time watch
        runtime = end - start                                                   # Calculating computationtime 
        print("Time taken to run is: ", runtime, "seconds")
        return best_order, c_max
    
def compute_makespan(total_jobs, permutation):
        # Describtion 
        "Compute makespan"
        col = np.array([])                                                      # Making an empty array for station 1
        last_row = total_jobs[permutation[-1]][1:5]                             # Saving last row in matrix for total products, substracting station 1
        for j in permutation: 
                col = np.append(col,total_jobs[j][0])                           # Saving first element for each product in current combination
                #print(col)
        makespan = np.sum(col) + np.sum(last_row)                               # Calculating the sum of all elements in first station adding the  
        return makespan                                                         # sum of the last row in the current combination

print(solve_problem(all_jobs))
#print(compute_makespan(all_jobs,joblist))

# # Defining the 2 products with time at the 5 stations. 
# p1 = np.array([5, 3, 3, 1, 10])
# p2 = np.array([10, 5, 3, 2, 10])

# total_jobs = np.concatenate([np.tile(p2,(40,1)),np.tile(p1,(30,1))])
# print(total_jobs[0])

# total_completion_time = total_jobs.sum(axis=1)
# print(total_completion_time)

# n = total_completion_time.shape[0]

# def heuristics_algorithm(total_jobs,total_completion_time):
#     n = total_completion_time.shape[0]
#     i = 3 
#     while i < (n+1): 
#         perms = create_permutations(best_order,total_completion_time[i-1])
#         c_max = np.inf
#         L = np.array_split(perms,i) 
#         for job in L: 
#             current_c_max = compute_makespan(total_jobs, job)
#             if current_c_max < c_max:
#                 c_max = current_c_max
#                 best_order = job 
#         i += 1 
#         print(c_max,best_order)
#     return best_order


# def create_permutations(list_jobs, job):
#         " Create permutations"
#         " [1,2], 3 -> [3,1,2], [1,3,2], [1,2,3]"
#         " Input list_jobs and job"
#         " list_jobs: A list of the jobs to make permutations of "
#         " job: The job that is inserted into the list_jobs "
#         " Output list_permutations "

#         list_permutations = np.array([])

#         for i in range(0,len(list_jobs) + 1):
#             #print(i)
#             perm = np.copy(list_jobs)
#             #print(perm)
#             perm = np.insert(perm, i, job)
#             list_permutations = np.append(list_permutations,perm)
#             #print(list_permutations)
#         return list_permutations

# #print(create_permutations(np.array([1,2]),3))
# #print(np.size(create_permutations(total_completion_time,1)))

# b = np.array([3, 1, 2, 1, 3, 2, 1, 2, 3])
# c = np.array_split(b,3)
# print(c[0][0])



# j1 = total_jobs[0].sum()
# j2 = np.array([total_jobs[1][0], 0, 0, 0, ]) + total_jobs[1]
# print(j1)
# print(j2)



