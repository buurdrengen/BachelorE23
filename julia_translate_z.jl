using DelimitedFiles
function julia_translate_z(filename, index)
    "Translate the matrix z from the flow-shop function to an order"
    "Input: File containing the matrix z, number of 1D products"
    "Output: Order of products as [1D,2D] instead of 1's and 0's "

    z_opt = readdlm(filename, skipstart =4) #Reading z-file

    location = [(i, j) for j in 1:size(z_opt)[1] for i in 1:size(z_opt)[2] if z_opt[i, j] > 0.5] # Finding index for 1

    vec_location = []
    for i in 1:size(location)[1] # Converting to useful vector
        position = location[i][1]
        append!(vec_location,position)
    end 

    name = String[]
    for i in 1:size(vec_location)[1] # Appending index to either product 1 or 2
        if 0 <= vec_location[i] <= index
            push!(name,"1D")
        else
            push!(name,"2D")
        end 
    end 
    
    return(name)

end 