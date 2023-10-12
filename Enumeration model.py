## Enumeration model 
import numpy as np 
from itertools import permutations
import time 

p1 = np.array([5, 3, 3, 1, 10])                                                 # Days for each station (step)
p2 = np.array([10, 5, 3, 2, 10])

no_p1 = 3                                                                       # 1D reflection
no_p2 = 4                                                                       # 2D reflection (wolter)

all_jobs = np.concatenate([np.tile(p2,(no_p2,1)),np.tile(p1,(no_p1,1))])        # Colleting all products in one array
#print(all_jobs)

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
        c_max = c_max + 60                                                      # Adding step 0 (activations days)
        end = time.time()                                                       # Stopping time watch
        runtime = end - start                                                   # Calculating computationtime 
        print("Time taken to run is: ", runtime, "seconds")
        return best_order, c_max
    
def compute_makespan(total_jobs, permutation):
        "Compute makespan for CHEXS production line "
        "Input: Matrix of products and permutation list "
        "Output: Makespan in days "
        first_row = np.sum(all_jobs[permutation[0]])
        next_finish = first_row
        for j in permutation[1:]:
                next_row = np.sum(all_jobs[j][0:4]) + all_jobs[permutation[j-1]][0]
                if next_row < first_row:
                      next_finish = next_finish + all_jobs[permutation[j]][-1]
                elif next_row > first_row: 
                      next_finish = next_finish + (next_row-first_row) + all_jobs[permutation[j]][-1]
                else:
                      next_finish = next_finish + all_jobs[permutation[j]][-1]
                first_row = next_finish
        makespan = next_finish                                                                        
        return makespan
                                             
print(solve_problem(all_jobs))



