# def dig_pow(n, p)
#   sum = 0
#   n.to_s.split("").each do |l|
#     sum += l.to_i**(p)
#     p += 1
#   end
#   sum % n == 0 ? (sum / n) : -1
# end

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
