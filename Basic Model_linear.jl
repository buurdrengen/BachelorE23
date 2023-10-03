## Test of model 

using JuMP
using Gurobi

m = Model(Gurobi.Optimizer); 

@variable(m, X[1:2] >= 0) 

@objective(m, Max, 2.5*X[1] + 4*X[2]) 

@constraint(m, 5*X[1] + 10*X[2] <= 230)
@constraint(m, 3*X[1] + 5*X[2] <= 230) 
@constraint(m, 3*X[1] + 3*X[2] <= 230)
@constraint(m, X[1] + 2*X[2] <= 230)
@constraint(m, 10*X[1] + 10*X[2] <= 230)
@constraint(m, X[1]>=3)
@constraint(m, X[2]>=4)

println(m)
optimize!(m)

println("Objective value: ",JuMP.objective_value(m))
println(solution_summary(m; verbose = true))
 
# latex_formulation(m)