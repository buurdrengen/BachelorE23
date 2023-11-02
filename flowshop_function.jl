using JuMP 
using Gurobi 
using Plots

model = Model(Gurobi.Optimizer); 

number_1D = 3
number_2D = Int.(ceil(number_1D*4/3))

p1 = [5, 3, 3, 1, 10]  
p2 = [10, 5, 3, 2, 10]

(antal,obj_value,p)=flowshop_function(p1,p2,number_1D,number_2D)

function flowshop_function(p1,p2,no_1D,no_2D)

    obj_value = []
    sol_time = []
    profit = []

    total_products = no_1D + no_2D

    unregister(model, :x)
    unregister(model, :y)
    unregister(model, :z)
    unregister(model, :c_max)
    
    p = hcat(repeat(p1, inner = (1,no_1D)), repeat(p2, inner =(1,no_2D)))
    
    m = 1:length(p1) # index k
    M = length(p1)
    n = 1:size(p,2) # index i og j

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

    @constraint(model, sum(sum(p[r,i]*z[i,1] for i in n) for r in 1:1)== x[1,2])
    @constraint(model, sum(sum(p[r,i]*z[i,1] for i in n) for r in 1:2) == x[1,3])
    @constraint(model, sum(sum(p[r,i]*z[i,1] for i in n) for r in 1:3) == x[1,4])
    @constraint(model, sum(sum(p[r,i]*z[i,1] for i in n) for r in 1:4) == x[1,5])

    K1 = 1:length(m)-1
    @constraint(model, [k in K1], y[1,k] == 0)

    optimize!(model)
    
    # Results

    obj_value = append!(obj_value,JuMP.objective_value(model))
    sol_time = append!(sol_time,solve_time(model))
    z_opt = value.(z)
    x_opt = value.(x)
    y_opt = value.(y)

    #Profit (In millions)
    salary = (0.0006*8) # 600 kr/hour for one employee in one work day (8 hours)
    cost_1D = (0.075+p1[1]*salary) + (0.15+p1[2]*salary) + (0.06+p1[3]*salary) + (0.25+p1[4]*salary) + (0.06+p1[5]*salary)
    cost_2D = (0.15+p2[1]*salary) + (0.13+p2[2]*salary) + (0.06+p2[3]*salary) + (0.45+p2[4]*salary) + (0.06+p2[5]*salary)
    price_1D = 2.5
    price_2D = 4
    profit_1D = price_1D-cost_1D
    profit_2D = price_2D-cost_2D
    profit = ((profit_1D*no_1D)+(profit_2D*no_2D))-(0.02+60*salary)

    # Save results in .txt files 
    f_name_z = "z_file.txt"
    f_name_results = "results.txt"
    touch(f_name_z) #Create .txt file 
    touch(f_name_results)

    # Printing the results to each file
    open(f_name_z,"w") do f
        print(f,z_opt)
    end 

    # Order of 2D and 1D
    z_order = julia_translate_z("z_file.txt", no_1D) 


    open(f_name_results,"w") do f
        println(f,"RESULTS OF $total_products PRODUCTS")
        println(f, "Makespan = " , obj_value, " Days")
        println(f, "Order = " , z_order)
        println(f, "Profit = " , profit, " Million DKK")
        println(f, "Solution time = " , sol_time)
        println(f,"")
        println(f,"X VALUES")
        println(f, x_opt)
        println(f,"")
        println(f,"Y VALUES")
        println(f,y_opt)
    end 

return total_products, obj_value, profit
end

