## Test of model 

using JuMP
using HiGHS

m = Model(HiGHS.Optimizer); 

@variable(m, X[1:2] >= 0) 

@objective(m, Max, 12*X[1] + 30*X[2]) 

@constraint(m, X[1] + 2*X[2] <= 230)
@constraint(m, 3*X[1] + 5*X[2] <= 230) 
@constraint(m, 7*X[1] + 17*X[2] <= 230)
@constraint(m, 7*X[1] + 14*X[2] <= 230)
@constraint(m, 3*X[1] + 6*X[2] <= 230)

println(m)
optimize!(m)

println("Objective value: ",JuMP.objective_value(m))
println(solution_summary(m; verbose = true))

# latex_formulation(m)