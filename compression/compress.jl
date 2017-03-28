function compressData(big, smallType, delta)
  # Initial arrays
  small1 = smallType[]
  small2 = smallType[]
  indexArr = Int64[]

  # Initial elements
  push!(small2, big[1] - smallType(big[1]))
  push!(small1, big[1])
  push!(indexArr, 1)
  prevElem = big[1]
  elem = big[1]

  for i = 2:length(big)
    if delta
      elem = big[i] - big[i-1]
    else
      elem = big[i]
    end
    #@printf("%0.20hf\n",elem - smallType(elem))
    push!(small2, elem - smallType(elem))
    #@printf("%0.20hf\n",small2[i])

    # Change most significant value
    if smallType(elem) != smallType(prevElem)
      push!(small1, elem)
      push!(indexArr, i)
    end

    prevElem = elem
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
N = 100000
doubleType = Float64
singleType = Float32
halfType = Float16

# Init doubleType
d1 = doubleType[]
for i = 1:N
  push!(d1, sin(2*pi*i/N))
end

deltaMethod = true
f1, f2, fMapArr = compressData(d1, singleType, deltaMethod)
verify(d1, f1, f2, fMapArr, doubleType, deltaMethod)

println(length(f1))
println(length(f2))

#deltaMethod = false
#h1, h2, hMapArr = compressData(f1, halfType, deltaMethod)
#verify(f1, h1, h2, hMapArr, singleType, deltaMethod)

#println(length(h1))
#println(length(h2))

function printVal(value, precisionType)
  value = convert(precisionType, value)
  @printf("%.20hf\n", value)
end

function printVals(values1, values2, indexArr, precisionType)
  j = 1
  for i = 1:length(values1)
    if j != length(indexArr) && i == indexArr[j + 1]
      j += 1
    end
    #print(i)
    #print(" ")
    #println(j)
    value1 = convert(precisionType, values1[j])
    value2 = convert(precisionType, values2[i])
    @printf("%.20hf %.20hf\n", value1, value2)

  end
end
