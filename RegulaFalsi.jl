"""
This is a simple method of false position that takes in a function and a bracket
and returns the root of the function with predefined tolerance 1e-8.
Args:
    f: function
    a: lower bound
    b: upper bound

Returns:
    iter: number of iterations
    a: lower bound
    b: upper bound
    root:  Root
    err: error
"""

# Import Packages
import Pkg
Pkg.add("Printf")
Pkg.add("Roots")
Pkg.add("Plots")
Pkg.add("LaTeXStrings")


using Roots 
using Plots 
using Printf
using LaTeXStrings


# We considered f(x) = x²-2, x ∈ [0,2] with the solution x = 1.4142135623730951
function f(x)
    return x^2 - 2
end

function RegulaFalsiMethod(f,x0,x1,TOL)
    k = 0;
    Rp = 1;
    @printf("_______________________________________\n \n");
    @printf("k        x0        x1       Rp         \n");
    @printf("_______________________________________\n \n");
    
    x2 = x0 - f(x0)*(x1-x0)/(f(x1)-f(x0))

    while Rp > TOL

        if f(x0)*f(x2) < 0
            x1 = x2
        else
            x0 = x2
        end

        x2 = x0 - f(x0)*(x1-x0)/(f(x1)-f(x0))

        Rp = abs(f(x2))
        
        k += 1;
        
        @printf("%1.0f %1.9f %1.9f %1.9f \n", k, x0,x1, Rp)
    
    end
    return x2
end

res = RegulaFalsiMethod(f,0,2,1e-8)

k1 = find_zero(f, (0, 2), FalsePosition(), verbose=true)

# Plot the function
x = range(0,stop=2,length=1000)
plot(x,f.(x),linewidth=3.0,xlabel=L"x",label=L"f(x)", legend=:topleft)
plot!([res],[0], markershape=:circle,markercolor=:red, markerstrokecolor=:black, markerstrokewidth=3,
	label= "Root",markersize=10)
plot!([k1],[0], markershape=:star,markercolor=:blue, markerstrokecolor=:black, markerstrokewidth=3,
	label= "Root by using Roots.jl",markersize=6)


