""" Simple Secant Algorithm to find a root of a function f(x) in the interval [a,b]
    This is a simple secant algorithm that takes in a function and two initial guess
    and returns the root of the function.
    Args:
        f: function
        x0: First initial Approximation
        x1: Second initial Approximation
        tol: tolerance
        
    Returns:
        Iter: number of iterations
        xc: Root of the function
        AbsErr: absolute error
        RelErr: relative error
"""

# Import Packages

import Pkg

Pkg.add("Printf")
Pkg.add("Roots")
Pkg.add("Plots.jl")
Pkg.add("LaTeXStrings")

# Load Packages

using Printf
using Roots
using LaTeXStrings
using Plots

# Define Function to be Rooted
# We considered f(x) = x²-2, x ∈ [0,2] with the solution x = 1.4142135623730951

function f(x)
    return x^2 - 2
end


function secant(f,x0,x1,tol)

    xold = x0;
    
    xc = x1 - (f(x1)*(x1-xold))/(f(x1)-f(xold));
    
    AbsErr = abs(xc-x0);
    
    RelErr = AbsErr/xc;

    i = 0;

    display("Iter   xc       AbsError   RelError")

    while abs(xc-xold) > tol;

        i += 1;

        xnew = xc - (f(xc)*(xc-xold))/(f(xc)-f(xold));
        
        AbsErr = abs(xnew-xold);
        
        RelErr =AbsErr/xnew;
        
        xold = xc;

        xc = xnew;


        @printf("%1.0f %1.9f %1.9f %1.9f \n", i, xc, AbsErr, RelErr)

    
    end
    
end 

secant(f,0.0,2.0,1e-8)

# Plot the function
x = range(0,stop=2,length=1000)
plot(x,f.(x),linewidth=2.0,xlabel=L"x",label=L"f(x)", legend=:right)
annotate!([(sqrt(2), 0, text(L"\sqrt{2}",12))])
