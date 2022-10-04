""" Simple fixed point iteration method to find a root of a function f(x) in the interval [a,b]
    This is a simple fixed point iteration that takes in a function and one initial guess
    and returns the root of the function.
    Args:
        f: Function
        x0: First initial Approximation
        maxIter: Maximum number of iterations
        TOL: Tolerance
        
    Returns:
        k: Number of iterations
        P: Root of the function
        Rp: Relative error
"""


# Import Packages
import Pkg
Pkg.add("Printf")
Pkg.add("Plots")
Pkg.add("LaTeXStrings")
Pkg.add("ForwardDiff")

# Load Packages
using Printf
using Plots
using LaTeXStrings
using ForwardDiff

# Define Function to be Rooted
# We considered f(x) = exp(-x), x ∈ [0,2] with the solution x = 0.567125341
function f(x)
    return exp(-x)
end

function FixPtIteration(x0, maxIter, TOL)

    k = 0; 
    Rp = 1; 
    P = f(x0)
    df = ForwardDiff.derivative(f, x0)

    if abs(df) < 1
        display("The method is convergent")
    else
        display("The method is divergent")
    end

    @printf("_____________________________\n \n");
    @printf("k        P         Rp    \n");
    @printf("_____________________________\n \n");

    while Rp > TOL && k < maxIter 
        Pnew = f(P)
        Rp = abs((Pnew-P)/P);
        P = Pnew;
        k = k + 1;
        @printf("%1.0f %1.9f %1.9f \n", k, P, Rp)
    end 
end 


FixPtIteration(0.5, 200, 1e-4)

