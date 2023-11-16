using Combinatorics

p1 = [5, 3, 3, 1, 10]                                                 
p2 = [10, 5, 3, 2, 10]

no_1D = 3  #Number of 1D products to be produced                                       
no_2D = 4  #Number of 2D products to be produced  


all_jobs = hcat(repeat(p2, inner = (1,no_2D)), repeat(p1, inner =(1,no_1D)))
@elapsed solve_problem(all_jobs) #Can be used if we want to time a single instance


function compute_perms(joblist)
        "Compute permutations of a joblist"
        "Input: Array with number of total products"
        "Inputexample: [1,2] (2 products)"
        "Output: Array with all permutations of input"
        "Outputexample: [[1,2],[2,1]]"
        P = []
        perms = permutations(joblist)
        for item in perms
             P = push!(P,item)
        end 
        return P   
end 

function solve_problem(total_jobs)
        "Main algorithm for computing makespan and order"
        "Input: Total jobs matrix of all products to be produced"
        "Output: Optimal order of products and total makespan"
        joblist = collect(1:size(total_jobs)[2]) 
        P = compute_perms(joblist)
        c_max = Inf                                                         
        best_order = []
        for i in P
                current_c_max = compute_makespan(total_jobs, i)
                if current_c_max < c_max
                        c_max = current_c_max
                        best_order = i
                        println(c_max, best_order)
                end 
        end                                
        c_max = c_max + 60                                 
        return best_order, c_max
end 
    
function compute_makespan(total_jobs, permutation)
        "Compute makespan for CHEXS production line "
        "Input: Matrix of products and permutation list "
        "Output: Makespan in days "
        first_row = sum(all_jobs[:,permutation[1]])
        first_val = all_jobs[1,permutation[1]]
        next_finish = first_row
        for j in permutation[2:end]
                next_row = sum(all_jobs[1:4,j]) + first_val
                if next_row < first_row
                        next_finish = next_finish + all_jobs[end,permutation[j]]
                elseif next_row > first_row
                        next_finish = next_finish + (next_row - first_row) + all_jobs[end,permutation[j]]
                else 
                        next_finish = next_finish + all_jobs[end,permutation[j]]
                end 
                first_row = next_finish
        end 
        makespan = next_finish
        return makespan
end 

################################################
# Solution time plot # 
################################################

p1_no = [1,2,3,4] #Change for 5 gives memoryerror 
p2_no = Int.(ceil.(p1_no*4/3))

soltime = []

for k in range(1,length(p1_no))
        all_jobs = hcat(repeat(p2, inner = (1,p2_no[k])), repeat(p1, inner =(1,p1_no[k])))
        X = @elapsed solve_problem(all_jobs)
        soltime = append!(soltime,X)
end
println(soltime)
xax = p1_no+p2_no

#Plotting 
using Plots
sol_time_plot = plot(
    xax,soltime; marker=(:circle,5), 
    color = "green", 
    # xticks = 0:50,
    # yticks = 0:0.01:3,
    xlabel = "Number of total products",
    ylabel = "Solution time [s]",
    label = "Solution time for each optimal value",
    fmt = :png)
png(sol_time_plot,"Results/solution_time_enumeration.png")


