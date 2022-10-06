""" Simple Bisection Algorithm
    This is a simple bisection algorithm that takes in a function and a bracket
    and returns the root of the function with predefined tolerance 1e-8.
    Args:
        f: function
        a: lower bound
        b: upper bound
        
    Returns:
        iter: number of iterations
        a: lower bound
        b: upper bound
        root: Average of a and b
        err: error
"""

# Import Packages
import Pkg
Pkg.add("Plots")
Pkg.add("Roots")
Pkg.add("Printf")
Pkg.add("LaTeXStrings")

# Load Packages
using Printf
using Plots
using Roots
using LaTeXStrings

# Define Function to be Rooted
# We considered f(x) = x²-2, x ∈ [0,2] with the solution x = 1.4142135623730951
function f(x)
    return x^2 - 2
end

# Interval 
a = 0.0; 
b = 2.0 

# Bisection Method 
function bisection(f,a,b)

    @printf("__________________________________________________\n \n");
    @printf("k        a         b         Root        Error    \n");
    @printf("__________________________________________________\n \n");

    
    if f(a)*f(b)>0 
        println("Failed")
    else
        p = (a + b)/2;
        i = 0 
        err = abs(f(p));
            while err > 1e-8
            i += 1
            if f(a)*f(p)<0 
                b = p;
            else
                a = p;
            end
            p = (a + b)/2; 
            err = abs(f(p));
            @printf("%1.0f %1.9f %1.9f %1.9f %1.9f \n", i, a, b, p, err)
        end
        return p 
    end
end 


res = bisection(f,0,2)

k1 = find_zero(f, (0,2), Bisection())

x = range(0,stop=2,length=1000)
plot(x,f.(x),linewidth=3.0,xlabel=L"x",label=L"f(x)", legend=:topleft)
plot!([res],[0], markershape=:circle,markercolor=:red, markerstrokecolor=:black, markerstrokewidth=3,
	label= "Root",markersize=10)
plot!([k1],[0], markershape=:star,markercolor=:blue, markerstrokecolor=:black, markerstrokewidth=3,
	label= "Root by using Bisection Method from Roots.jl",markersize=6)

