#!/usr/bin/ruby

#Apache log
#Jackson Hall
#CIT 383-001 & 002
#04/3/2018


header = <<-HEAD
-----------------------------------------------------
Statistics for the Apache log file access_log
-----------------------------------------------------
HEAD

if ARGV.empty?
  raise ArgumentError, 'A file name must be provided'
  exit
end

#defines the hashes
ip_hash = Hash.new(0)
url_hash = Hash.new(0)
status_hash = Hash.new(0)

begin
  line_array = File.readlines(ARGV[0])
rescue SystemCallError, ArgumentError => e
  puts ("Exception type: #{e.class}")
  puts ("Message: #{e.message}")
  exit
end

puts header

line_array.each do |line|
  md = line.match(/^([:\d\.]+) .*\[.*\].*\"[A-Z]+ *(.+) HTTP.{6}(\d{3})/)

  ip = md[1]
    ip_hash[ip] += 1

  url = md[2]
    url_hash[url] += 1

  status = md[3]
   status_hash[status] += 1
end

puts "Frequency of Client IP Addresses:"
ip_hash.each do |k, v|
  puts k.to_s.ljust(20) + " " + ("*" * v.to_i)
end
puts ""

puts "Frequency of URLs Accessed:"
url_hash.each do |k, v|
  printf k.to_s.ljust(50) + " " + v.to_s + "\n"
end
puts ""


puts "HTTP Status Codes Summary:"
status_hash.each do |k, v|
  v = (v.to_f / line_array.size) * 100
  puts "#{k}" + ":"  + " " + "#{v.round(2)}" + "%"
end

