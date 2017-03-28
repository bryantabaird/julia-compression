N = 1000000

for i = 1:5
  d[i] = sin(2*pi*i/N)
end

d1 = sin(2*pi*1/1000000)
d2 = sin(2*pi*2/1000000)
d3 = sin(2*pi*3/1000000)
d4 = sin(2*pi*4/1000000)
d5 = sin(2*pi*5/1000000)

precision(BigFloat)
setprecision(BigFloat, 32)
precision(BigFloat)

for i = 1:5
  f0 = BigFloat(d[i])
  temp = d[i] - f0
  f1b = BigFloat(temp)
end

f2a = BigFloat(d[2])
d2a = d2 - f0
f2b = BigFloat(d2a)

f3a = BigFloat(d3)
d3a = d3 - f0
f3b = BigFloat(d3a)

f4a = BigFloat(d4)
d4a = d4 - f0
f4b = BigFloat(d4a)

f5a = BigFloat(d5)
d5a = d5 - f0
f5b = BigFloat(d5a)
