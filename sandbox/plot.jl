Pkg.add("Plots")
using Plots
plotly() # Choose the Plotly.jl backend for web interactivity
plot(f1,linewidth=1,title="F1")
plot(f2[1:100],linewidth=1,title="F2")
