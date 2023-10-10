using JuMP 
using Gurobi 
using Plots

model = Model(Gurobi.Optimizer); 

No_products = [[1,2] [2,3] [3,4] [4,5] [5,6] [6,7] [10,11]]
#  optimizer(No_products)

# function optimizer(No_products)

p1 = [5, 3, 3, 1, 10]  
p2 = [10, 5, 3, 2, 10]

obj_value = []


for t in 1:size(No_products,2)
    unregister(model, :x)
    unregister(model, :y)
    unregister(model, :z)
    unregister(model, :c_max)
    println(t)

    p = hcat(repeat(p1, inner = (1,No_products[1,t])), repeat(p2, inner =(1,No_products[2,t])))
    
    m = 1:length(p1) # index k
    M = length(p1)
    n = 1:size(p,2) # index i og j


    @variable(model, x[n,m] >= 0) 
    @variable(model, y[n,m] >= 0) 
    z = @variable(model, z[n,n], Bin)
    @variable(model, c_max >= 0)

    @objective(model, Min, c_max+60) 

    @constraint(model, [i in n], sum(z[i,j] for j in n) == 1)
    @constraint(model, [j in n], sum(z[i,j] for i in n) == 1)

    J = 1:length(n)-1
    R = 1:length(m)-1
    @constraint(model, [j in J, r in R], sum(p[r,i]*z[i,j+1] for i in n) + y[j+1,r] + x[j+1,r] == y[j,r] + sum(p[r+1,i]*z[i,j] for i in n) + x[j+1,r+1])

    @constraint(model, sum(sum(p[M,i]*z[i,j] for i in n) for j in n) + sum(x[j,M] for j in n) == c_max)

    K = 2:length(m)
    @constraint(model, [k in K], sum(sum(p[r,i]*z[i,1] for i in n) for r in R) == x[1,k])

    K1 = 1:length(m)-1
    @constraint(model, [k in K1], y[1,k] == 0)

    #println(model)
    optimize!(model)
    
    obj_value = append!(obj_value,JuMP.objective_value(model))
    #println("Objective value: ",JuMP.objective_value(model))
    z_opt = value.(z)
    # order = [key for key in eachindex(z) if z_opt[key] > 0.5]
    order = z[z_opt .> 0.5]
    println(order)
end 
#     return order
# end

#findall(x->x==1, z)

# println(obj_value)

#println(solution_summary(model; verbose = true))

# total_products = vec(sum(No_products, dims=1))
# scatter(total_products,obj_value,label = ["Optimal number of days"],xlabel = ["Number of total products"],ylabel = ["Number of work days"])