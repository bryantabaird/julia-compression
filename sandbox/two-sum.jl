function twoSum(a, b)
  x = a + b
  bVirtual = x - a
  aVirtual = x - bVirtual
  bRoundOff = b - bVirtual
  aRoundOff = a - aVirtual
  y = aRoundOff + bRoundOff
  return x, y
end


x, y = twoSum(3.25, 0b1101)

for i = 1:10000000
  a = rand() * 10
  b = rand() * 10
  x, y = twoSum(a, b)
  @assert a + b == x + y
end
