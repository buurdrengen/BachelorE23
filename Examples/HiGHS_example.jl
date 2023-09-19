# Problem: 
# Min x + y 
# s.t. 
# 5 <= x + 2y <= 15
# 6 <= 3x + 2y 
# 0 <= x <= 4
# 1 <= y
# y in Z (y is integer)

using JuMP 
using HiGHS 

m = Model(HiGHS.Optimizer)

@variable(m, 0 <= x <= 4)
@variable(m, 1 <= y, Int)

@objective(m, Min, (x + y))
@constraint(m, 5 <= (x + 2*y) <= 15)
@constraint(m, 6 <= (3*x + 2*y))

optimize!(m)

println("Objective value: ",JuMP.objective_value(m))
println("x: ",JuMP.value(x))
println("y: ",JuMP.value(y))
