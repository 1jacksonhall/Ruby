#!/usr/bin/ruby

#Program #1 - random number generator
#Jackson Hall
#CIT 383 001&002 Fall 2018
#2/10/2018

#Gets the amount of numbers to generate
puts "How many random integer numbers do you want to generate?"
amount = gets.chomp.to_i


#Gets the max number in the range
puts "Please input the maximum value for the random numbers"
max = gets.chomp.to_i

#Prints the array of random integers generated including the max
numbers = Array.new(amount - 1) {rand(1...max)}
numbers << max


#creates new hash adding each integer in the number array
#Each time an integer is found (frequency) +1 will be added to its value
frequency = Hash.new(0)
numbers.each {|k| frequency[k] += 1}
frequency = frequency.sort_by {|k, v|v}


#sorts each item in the hash and prints
frequency.each do |k, v|
  puts "The frequency of " + k.to_s + " | " + v.to_s
end
