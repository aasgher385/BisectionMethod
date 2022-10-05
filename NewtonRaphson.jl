""" Simple Newton-Raphson Algorithm to find a root of a function f(x) in the interval [a,b]
    This is a simple Newton-Raphson algorithm that takes in a function, an initial guess, maximum number 
    of iterations and tolerance and returns the root of the function.
    and returns the root of the function.
    Args:
        f: function
        x0: initial Approximation
        TOL: tolerance
        maxIter: maximum number of iterations
        
    Returns:
        k: number of iterations
        xnew: Root of the function
        RelErr: relative error
"""


# Import Packages

import Pkg

Pkg.add("Printf")
Pkg.add("Roots")
Pkg.add("Plots")
Pkg.add("LaTeXStrings")

# Load Packages


using Roots
using Plots
using Printf
using ForwardDiff
using LaTeXStrings


# We considered f(x)=x³-x²+2, x ∈ [-2,2] with the solution x = -1.0

function f(x)
    return x^3 - x^2 + 2
end

D(f) = x -> ForwardDiff.derivative(f,float(x))

function NewtonRaphson(f,x0,maxIter,TOL)

    k = 0; 

    RelError = 1

    @printf("___________________________________\n \n");
    @printf("k        x         Relative Error    \n");
    @printf("___________________________________\n \n");

    while RelError > TOL && k < maxIter

        xold = x0

        df = ForwardDiff.derivative(f, xold)

        if abs(df) == 0
            display("Mathematical Error: Newton Method is not applicable")
        end
        
        xnew = xold - f(xold)/df
    
        x0 = xnew

        RelError = abs((xnew-xold)/xnew)
    
        k = k + 1
    
        @printf("%1.0f %1.9f %1.9f \n", k, xnew, RelError)
    
    end 
        
end

NewtonRaphson(f,0.5,15,1e-6)

k1=find_zero((f, D(f)),0.5, Roots.Newton(), verbose=true)

# Plot the function
x = range(-2,stop=2,length=1000)
plot(x,f.(x),linewidth=2.0,xlabel=L"x",label=L"f(x)", legend=:right)
plot!([-1],[0], markershape=:circle,markercolor=:red, markerstrokecolor=:black, markerstrokewidth=3,
	label= "Root",markersize=10)
plot!([k1],[0], markershape=:star,markercolor=:blue, markerstrokecolor=:black, markerstrokewidth=3,
	label= "Root by using Newton Raphson Method from Roots.jl",markersize=6)
