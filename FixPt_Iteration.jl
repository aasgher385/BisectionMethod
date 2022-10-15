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

Pkg.add("Plots")
Pkg.add("Printf")
Pkg.add("Roots")
Pkg.add("ForwardDiff")
Pkg.add("LaTeXStrings")



# Load Packages
using Plots
using Printf
using ForwardDiff
using LaTeXStrings
using Roots



# We considered f(x) = x³+x-1, x ∈ [-2,2] with the solution x = 0.6823278038280193
function f(x)
    return x^3 + x -1
end

# Modifying the function f(x)=0 to g(x)=x
function g(x)
    return 1/(x^2+1)
end

function FixPtIteration(x0, maxIter, TOL)

    k = 0; 
    Rp = 1; 
    P = g(x0)
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
        Pnew = g(P)
        Rp = abs((Pnew-P)/Pnew)
        P = Pnew;
        k = k + 1;
        @printf("%1.0f %1.9f %1.9f \n", k, Pnew, Rp)
    end 
    return P
end 


res = FixPtIteration(0.5, 200, 1e-4)


k1 = find_zero(f, (-2, 2), FalsePosition(), verbose=true)
# Plot the function
x = range(-2,stop=2,length=1000)
plot(x,f.(x),linewidth=3.0,xlabel=L"x",label=L"f(x)", legend=:topleft)
plot!([res],[0], markershape=:circle,markercolor=:red, markerstrokecolor=:black, markerstrokewidth=3,
	label= "Root",markersize=10)
plot!([k1],[0], markershape=:star,markercolor=:blue, markerstrokecolor=:black, markerstrokewidth=3,
	label= "Root by using Roots.jl",markersize=6)



