## Extra station 5 
using JuMP 
using Gurobi 

model = Model(Gurobi.Optimizer); 

J1 = 3
J2 = 4

p1 = [5, 3, 3, 1, 10]  
p2 = [10, 5, 3, 2, 10]
p = hcat(repeat(p1, inner = (1,J1)), repeat(p2, inner =(1,J2)))
m = 1:length(p1) # index k
M = length(p1)
n = 1:(J1+J2) # index i og j


@variable(model, x[n,m] >= 0) 
@variable(model, y[n,m] >= 0) 
@variable(model, z[n,n], Bin)
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

println(model)
optimize!(model)

println("Objective value: ",JuMP.objective_value(model))
println(solution_summary(model; verbose = true))  

#x_df = JuMP.variable_by_name(model, x)