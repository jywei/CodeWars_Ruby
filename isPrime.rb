require 'prime'

def isPrime(num)
  unless num < 2
    Math.sqrt(num).floor.downto(2).each {|i| return false if num % i == 0}
    true
  else
    false
  end
end
