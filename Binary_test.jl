# 
using JuMP
using GLPK
M = 34
m = Model(GLPK.Optimizer);
@variable(m, x[1:3] >= 0)
@variable(m, y[1:4], Bin)


@objective(m, Max, 5*x[1] + 7*x[2] + 3*x[3])
@constraint(m, x[1] <= 7)
@constraint(m, x[2] <= 5)
@constraint(m, x[3] <= 9)

@constraint(m,x[1] - M*y[1] <= 0)
@constraint(m,x[2] - M*y[2] <= 0)
@constraint(m,x[3] - M*y[3] <= 0)

@constraint(m, y[1] + y[2] + y[3] <= 2)

@constraint(m, 3*x[1] + 4*x[2] + 2*x[3] - M*y[4] <= 30)
@constraint(m, 4*x[1] + 6*x[2] + 2*x[3] + M*y[4] <= 40 + M)

optimize!(m)

println("Objective value: ", JuMP.objective_value(m))
println("x1 = ",JuMP.value(x[1]))
println("x2 = ",JuMP.value(x[2]))
println("x3 = ",JuMP.value(x[3]))

println("y1 = ",JuMP.value(y[1]))
println("y2 = ",JuMP.value(y[2]))
println("y3 = ",JuMP.value(y[3]))
println("y4 = ",JuMP.value(y[4]))