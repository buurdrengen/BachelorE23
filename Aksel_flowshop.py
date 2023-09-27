## Aksel - flowshop work
import numpy as np 
from itertools import permutations
import time 

p1 = np.array([5, 3, 3, 1, 10])
p2 = np.array([10, 5, 3, 2, 10])

no_p1 = 3
no_p2 = 5

all_jobs = np.concatenate([np.tile(p1,(no_p1,1)),np.tile(p2,(no_p2,1))])

def solve_problem(total_jobs):
        start = time.time()
        joblist = np.arange(0,len(total_jobs))
        #print(joblist)
        permutation = list(permutations(joblist))
        c_max = np.inf
        best_order = np.array([])
        for i in permutation:
            current_c_max = compute_makespan(total_jobs, i)
            if current_c_max < c_max:
                c_max = current_c_max
                best_order = i 
                print(c_max, best_order)
            #elif current_c_max = c_max:
        c_max = c_max + 60
        end = time.time()
        runtime = end - start 
        print("Time taken to run is: ", runtime, "seconds")
        return best_order, c_max
    
def compute_makespan(total_jobs, permutation):
        "Compute makespan"
        col = np.array([])
        last_row = total_jobs[permutation[-1]][1:5]
        for j in permutation: 
                col = np.append(col,total_jobs[j][0])
                #print(col)
        makespan = np.sum(col) + np.sum(last_row)
        return makespan 

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



