function twoDiff(a, b)
  x = a - b
  bVirtual = a - x
  aVirtual = x + bVirtual
  bRoundOff = bVirtual - b
  aRoundOff = a - aVirtual
  y = aRoundOff + bRoundOff
  return x, y
end

for i = 1:10000000
  a = rand() * 10
  b = rand() * 10
  x, y = twoDiff(a, b)
  @assert a - b == x - y
end
