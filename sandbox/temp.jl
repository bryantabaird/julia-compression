f32 = Float32(3.0)
f64 = Float64(3.0)
tempy = convert(Float64, f32)
typeof(tempy)


foo = Float32[1.0, 2.0]

bar = convert(Array{Float64},foo)

typeof(foo)
typeof(bar)
typeof(foo[1])
typeof(bar[1])

function f(d, dataType)
  f = convert(Array{dataType}, d)
  f
end

res = f(bar, typeof(Float32(3.0)))
