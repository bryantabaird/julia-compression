function compressData(big, smallType, delta)
  # Initial arrays
  small1 = smallType[]
  small2 = smallType[]
  indexArr = UInt64[]

  if delta

    # Initial elements
    push!(small2, big[1] - smallType(big[1]))
    push!(small1, big[1])
    push!(indexArr, 1)
    prevDelta = big[1]
    delta = big[1]

    for i = 2:length(big)
      delta = big[i] - big[i-1]
      push!(small2, delta - smallType(delta))

      # Change most significant value
      if smallType(delta) != smallType(prevDelta)
        push!(small1, delta)
        push!(indexArr, i)
      end

      prevDelta = delta
    end
  else
    # Initial elements
    push!(small2, big[1] - smallType(big[1]))
    push!(small1, big[1])
    push!(indexArr, 1)

    for i = 2:length(big)
      push!(small2, big[i] - smallType(big[i]))

      # Change most significant value
      if smallType(big[i]) != smallType(big[i-1])
        push!(small1, big[i])
        push!(indexArr, i)
      end
    end

  end


  small1, small2, indexArr
end

function verify(big, small1, small2, indexArr, startType, delta)
  # Loop through index array to map small2 to f values
  for i = 1:length(indexArr)
    start = 1
    finish = indexArr[i]
    #println(i)

    # Handle edge cases
    if i == length(indexArr)
      start = indexArr[i]
      finish = length(big)
    elseif i == 1
      start = 1
      finish = indexArr[i+1] - 1
    else
      start = indexArr[i]
      finish = indexArr[i+1] - 1
    end

    # Verify results
    for j = start:finish
      t1 = convert(startType, small1[i]) + convert(startType, small2[j])

      if j != 1
        if delta
          t2 = big[j] - big[j-1]
        else
          t2 = big[j]
        end
      else
        t2 = big[1]
      end
      #println("$j: $(t1)")
      #println("$j: $(t2)")
      @assert abs(t1-t2) < eps(startType)
    end
  end
end

# Main script ---------


# Initial parameters
N = 1000000
doubleType = Float64
singleType = Float32
halfType = Float16

# Init doubleType
d1 = doubleType[]
for i = 1:N
  push!(d1, sin(2*pi*i/N))
end

f1, f2, fMapArr = compressData(d1, singleType, true)
verify(d1, f1, f2, fMapArr, doubleType, true)

println(length(f1))
println(length(f2))

h1, h2, hMapArr = compressData(f1, halfType, false)
verify(f1, h1, h2, hMapArr, singleType, false)

println(length(h1))
println(length(h2))
