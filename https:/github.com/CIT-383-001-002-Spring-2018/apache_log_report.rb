#!/usr/bin/ruby
 
#Apache log
#Jackson Hall
#CIT 383-001 & 002
#03/13/2018
 
header = <<-HEAD
-----------------------------------------------------
Statistics for the Apache log file access_log
-----------------------------------------------------
HEAD
puts header
 
 
line_array = File.readlines("access_log")
 
#defines the hashes
ip_hash = Hash.new(0)
url_hash = Hash.new(0)
status_hash = Hash.new(0)

line_array.each do |line|
  md = line.match(/^([:\d\.]+) .*\[.*\].*\"[A-Z]+ *(.+) HTTP.{6}(\d{3})/)
  ip = md[1]
    ip_hash[ip] += 1
	
  url = md[2]
    url_hash[url] += 1

  status = md[3]
    status_hash[status] += 1
end

#sorts each hash with key and frequency of each key

#IP Hash
puts "Frequency of Client IP Addresses:"
ip_hash.each do |k, v|
  puts k.to_s.ljust(20) + " " + ("*" * v.to_i)
end
puts ""

#URL Hash
puts "Frequency of URLs Accessed:"
url_hash.each do |k, v|
  printf k.to_s.ljust(50) + " " + v.to_s + "\n"
end
puts ""

#Status Hash
puts "HTTP Status Codes Summary:"
status_hash.each do |k, v|
  v = (v.to_f / line_array.size) * 100
  puts "#{k}" + ":"  + " " + "#{v.round(2)}" + "%"
end
