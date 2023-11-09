using Combinatorics
using TickTock
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

all_jobs = hcat(repeat(p2, inner = (1,no_2D)), repeat(p1, inner =(1,no_1D)))

println(solve_problem(all_jobs))

function compute_perms(joblist)
        P = []
        perms = permutations(joblist)
        for item in perms
             P = push!(P,item)
        end 
        return P   
end 

function solve_problem(total_jobs)
        tick()
        joblist = collect(1:size(total_jobs)[2])
        #println(joblist)
        P = compute_perms(joblist)
        c_max = 10000                                                         
        best_order = []
        for i in P
                #println("i = ",i)
                current_c_max = compute_makespan(total_jobs, i)
                if current_c_max < c_max
                        c_max = current_c_max
                        best_order = i
                        println(c_max, best_order)
                end 
        end                                
        c_max = c_max + 60
        elapsed = tock()                                                       
        return best_order, c_max, elapsed
end 
    
function compute_makespan(total_jobs, permutation)
        "Compute makespan for CHEXS production line "
        "Input: Matrix of products and permutation list "
        "Output: Makespan in days "
        first_row = sum(all_jobs[:,permutation[1]])
        first_val = all_jobs[1,permutation[1]]
        #println("first row = ",first_row)
        next_finish = first_row
        for j in permutation[2:end]
                #println("j = ",j)
                next_row = sum(all_jobs[1:4,j]) + first_val
                #println("next_row = ",next_row)
                if next_row < first_row
                        next_finish = next_finish + all_jobs[end,permutation[j]]
                        #println("next_finish1 = ", next_finish)
                elseif next_row > first_row
                        next_finish = next_finish + (next_row - first_row) + all_jobs[end,permutation[j]]
                        #println("next_finish2 = ", next_finish)
                else 
                        next_finish = next_finish + all_jobs[end,permutation[j]]
                        #println("next_finish3 = ", next_finish)
                end 
                first_row = next_finish
        end 
        makespan = next_finish
        #println("makespan = ",makespan)                                                                        
        return makespan
end 


p1_no = [1,2,3,4,5,6,7]
p2_no = Int.(ceil.(p1_no*4/3))


#all_jobs = np.concatenate([np.tile(p2,(no_p2,1)),np.tile(p1,(no_p1,1))])        # Colleting all products in one array
#print(np.shape(all_jobs))

soltime = []
for k in range(1,length(p1_no))
        #print(k)
        all_jobs = hcat(repeat(p2, inner = (1,p2_no[k])), repeat(p1, inner =(1,p1_no[k])))
        #print(all_jobs)
        X = solve_problem(all_jobs)
        soltime = append!(soltime,X)
        #print("X equals: ",X[2])
end
print(soltime)

