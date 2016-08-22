# def dig_pow(n, p)
#   # your code
#   while p < Math.log10(n).to_i + 2
#     digit = n / 10**(p+1)
#     num = digit**p
#     p += 1
#     return num += num
#   end
# end
#

def dig_pow(n, p)
  # your code
  num = n.to_s
  total = 0
  for i in (0..(num.size - 1))
    total += (num[i].to_i) ** (p + i)
  end


  if total % n == 0
    total / n
  else
    -1
  end
end

puts dig_pow(89, 1)
puts dig_pow(92, 1)
puts dig_pow(46288, 3)
