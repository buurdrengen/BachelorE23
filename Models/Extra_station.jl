## Extra station 5 
using JuMP 
using Gurobi 

model = Model(Gurobi.Optimizer); 

J1 = 3 #Number of 1D products
J2 = 4 #Number of 2D products

p1 = [5, 3, 3, 1, 10] #Original process time 1D product
p2 = [10, 5, 3, 2, 10] #Original process time 2D product
p3 = [10, 5, 5, 2, 10] #Changed process time station 3, 2D product
p4 = [5, 1, 1, 2, 2, 1, 10] #Extra station 1D product
p5 = [10, 1, 1, 4, 4, 2, 10] #Extra station 2D product
p = hcat(repeat(p4, inner = (1,J1)), repeat(p5, inner =(1,J2))) #Use p1 and p3 for changed process time and p4 and p5 for extra stations
m = 1:length(p4) # index k
M = length(p4)
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
@constraint(model, sum(sum(p[r,i]*z[i,1] for i in n) for r in 1:4) == x[1,5])
@constraint(model, sum(sum(p[r,i]*z[i,1] for i in n) for r in 1:5) == x[1,6])
@constraint(model, sum(sum(p[r,i]*z[i,1] for i in n) for r in 1:6) == x[1,7])

K1 = 1:length(m)-1
R2 = 1:length(m)-1
J5 = 1:length(n)

@constraint(model, [j in n], x[j,1] == 0)
M1 = 1000
@constraint(model, [j in J5, r in R2], x[j,r + 1] <= M1*q[j,r])
@constraint(model, [j in J5, r in R2], y[j,r] <= M1*(1-q[j,r]))

#println(model) #Can be activated to print the model 
optimize!(model)

y_opt = value.(y)
x_opt = value.(x)
z_opt = value.(z)
q_opt = value.(q)
println(y_opt)
println(x_opt)
println(z_opt)
println(q_opt)

f_name = "z-7product.txt" #Create file to obtain the order
touch(f_name)
open(f_name,"w") do f
    print(f,z_opt)
end 

println("Objective value: ",JuMP.objective_value(model)) #Makespan 
println(julia_translate_z("z-7product.txt", J1)) #Prints the optimal order 