function fastTwoSum(a, b)
  x = a + b
  bVirtual = x - a
  y = b - bVirtual
  return x, y
end

fastTwoSum(1.1, .1)
fastTwoSum(.1, 1.1)

1.1 + .1
Float64(Float64(1.1) + Float32(.1))

float64(3)

@printf "%.100f" BigFloat(1.1 + .1)
