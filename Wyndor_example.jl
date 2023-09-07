# Wyndor example 

using JuMP # Importing relevant packages 
using GLPK # Importing the solver 

model = Model(GLPK.Optimizer) # Defining the model to be optimized by the solver

@variable(model, x[1:2] >= 0) # Defining the decisions variables x1 and x2

@objective(model, Max, 3*x[1] + 5*x[2]) # Setting the objective (choosing "Max" as for maximizing the function)
@constraint(model, x[1] <= 4) # Defining the constraints 
@constraint(model, 2*x[2] <= 12)
@constraint(model, 3*x[1] + 2*x[2] <= 18)

optimize!(model) # Optimizing the model (using the simplex algorithm)

println("Objective value (maximum profit in 1000 DKK) is: ",JuMP.objective_value(model))
println("The number of doors (x1) should be: ",JuMP.value(x[1]))
println("The number of windows (x2) should be: ",JuMP.value(x[2]))


