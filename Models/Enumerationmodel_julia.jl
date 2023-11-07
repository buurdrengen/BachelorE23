using Combinatorics
# A = [1,2,3]
# n = factorial(length(A))
# N = 1:n
# B = permutations(A)
# p = []
# for item in B
#     println(item)
#     p = push!(p,item)
# end 
# println(p)
p1 = [5, 3, 3, 1, 10]                                                 
p2 = [10, 5, 3, 2, 10]

no_1D = 3                                                
no_2D = 4

total_jobs = hcat(repeat(p1, inner = (1,no_1D)), repeat(p2, inner =(1,no_2D)))
println(total_jobs)
# perms = permutations(total_jobs)
# P = []
# for item in perms
#     P = push!(P,item)
# end 

function create_perm(procesmatrix)
    "Creates all permutations for products to be produced"
    "Input: Procestime-matrix"
    "Output: Matrix of all permutations"
    perms = permutations(procesmatrix)
    P = []
    for item in perms
        P = push!(P,item)
    end 
    return P 
end 
@time create_perm(total_jobs)


function solve_problem(total_jobs):
        # Describtion 
        perms = permutations(total_jobs)
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
        return best_order, c_max, runtime
    
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
                                             

p1_no = np.array([1,2,3,4])
p1_no = p1_no.astype(int)
p2_no = np.ceil(p1_no*4/3)
p2_no = p2_no.astype(int)


#all_jobs = np.concatenate([np.tile(p2,(no_p2,1)),np.tile(p1,(no_p1,1))])        # Colleting all products in one array
#print(np.shape(all_jobs))

soltime = np.array([])
for k in range(0,len(p1_no)):
        #print(k)
        all_jobs = np.concatenate([np.tile(p2,(p2_no[k],1)),np.tile(p1,(p1_no[k],1))])
        #print(all_jobs)
        X = solve_problem(all_jobs)
        soltime = np.append(soltime,X[2])
        #print("X equals: ",X[2])
print(soltime)

import matplotlib.pyplot as plt 
x_plot = p1_no + p2_no 
print(x_plot)

scat = plt.plot(x_plot,soltime,'-')
plt.scatter(x_plot,soltime)
plt.grid()
plt.ylabel("Runtime [s]")
plt.xlabel("Number of total products")
plt.legend(["Solution time for each optimal value"])
plt.savefig("Results/Enumeration.png")
plt.show()