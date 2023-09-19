## Test of model 

using JuMP
using HiGHS

m = Model(HiGHS.Optimizer); 

@variable(m, X[1:2,1:5] >= 0)

@objective(m, Max, sum(X[i,j] for i =1:2, j=1:5) )

@constraint(m, X[1,1] + 2*X[2,1] <= 230)
@constraint(m, 3*X[1,2] + 5*X[2,2] <= 230)
@constraint(m, 7*X[1,3] + 17*X[2,3] <= 230)
@constraint(m, 7*X[1,4] + 14*X[2,4] <= 230)
@constraint(m, 3*X[1,5] + 6*X[2,5] <= 230)

println(m)
optimize!(m)

println("Objective value: ",JuMP.objective_value(m))
println(solution_summary(m; verbose = true))

#latex_formulation(m)
