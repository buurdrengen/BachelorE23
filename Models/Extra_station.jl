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
pq1 = 1:(length(n)-1)
pq2 = 1:(length(m)-1)
unregister(model, :x)
unregister(model, :y)
unregister(model, :z)
unregister(model, :c_max)
unregister(model, :q)

@variable(model, x[n,m] >= 0) 
@variable(model, y[n,m] >= 0) 
@variable(model, z[n,n], Bin)
@variable(model, c_max >= 0)
@variable(model, q[n, pq2], Bin)

@objective(model, Min, c_max+60) 

J = 1:length(n)-1
R = 1:length(m)-1

@constraint(model, [i in n], sum(z[i,j] for j in n) == 1)
@constraint(model, [j in n], sum(z[i,j] for i in n) == 1)


@constraint(model, [j in J, r in R], sum(p[r,i]*z[i,j+1] for i in n) + y[j+1,r] + x[j+1,r] == y[j,r] + sum(p[r+1,i]*z[i,j] for i in n) + x[j+1,r+1])

@constraint(model, sum(sum(p[M,i]*z[i,j] for i in n) for j in n) + sum(x[j,M] for j in n) == c_max)


@constraint(model, sum(sum(p[r,i]*z[i,1] for i in n) for r in 1:1) == x[1,2])
@constraint(model, sum(sum(p[r,i]*z[i,1] for i in n) for r in 1:2) == x[1,3])
@constraint(model, sum(sum(p[r,i]*z[i,1] for i in n) for r in 1:3) == x[1,4])
@constraint(model, sum(sum(p[r,i]*z[i,1]    for i in n) for r in 1:4) == x[1,5])

K1 = 1:length(m)-1
R2 = 1:length(m)-1
J1 = 1:length(n)
#@constraint(model, [k in K1], y[1,k] == 0)
@constraint(model, [j in n], x[j,1] == 0)
M1 = 1000
@constraint(model, [j in J1, r in R2], x[j,r + 1] <= M1*q[j,r])
@constraint(model, [j in J1, r in R2], y[j,r] <= M1*(1-q[j,r]))

# @constraint(model, [k in K1, j in J], y[j,k+1] >= y[j,k] - x[j,k])

# @constraint(model, y[2,4] == 5)

# @constraint(model, y[3,4] == 2)
# @constraint(model, y[4,4] == 2)
# @constraint(model, y[5,4] == 2)
# @constraint(model, y[6,4] == 2)
# @constraint(model, y[7,4] == 10)

#@constraint(model, y[2,4] == sum(sum(p[r,i]*z[i,1] for i in n) for r in m) - sum(sum(p[r,i]*z[i,1] for i in n) for r in K1) - sum(p[1,i]*z[i,1] for i in n))
println(model)
optimize!(model)

y_opt = value.(y)
x_opt = value.(x)
z_opt = value.(z)
q_opt = value.(q)
println(y_opt)
println(x_opt)
println(z_opt)
println(q_opt)
println(y_opt[2,1])
println(z_opt[:,1])
#println( sum(p[5,i]*z_opt for i in n))
println(p)
f_name = "z-7product.txt"
touch(f_name)
open(f_name,"w") do f
    print(f,z_opt)
end 

println("Objective value: ",JuMP.objective_value(model))
println(julia_translate_z("z-7product.txt",3))

#println(solution_summary(model; verbose = true))  

# 

# for k=2:length(m)
#     for r=1:k-1
#         cons += sum(p[r,i]*z[i,1] for i in n) 
#         #print(cons)
#     end
# end 

