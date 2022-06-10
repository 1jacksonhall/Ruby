#!/usr/bin/ruby

require 'optparse'
require 'open3'

command = "last"

optparser = OptionParser.new

# $0 is the name of the program, similar to Bash $0
optparser.banner = "USAGE: #{$0}" # notice the actual help message
#check for each argument for the "last" command
optparser.on('-w', "--fullname", "Run Fullname") do
  command = "#{command}" + " -w"
end
optparser.on('-i', "--ip", "Ip Address") do
  command = "#{command}" + " -i"
end
optparser.on('-f INFILE', "--alt_file INFILE", "File name") do |file|
  command = "#{command}" + " -f #{file}"
end
optparser.on('-o OUTFILE', "--output OUTFILE", "File name") do |file|
  command = "#{command}" + " -o #{file}"
end
optparser.on('-h', "--help", "Help") do
  command = "#{command}" + " -h"
end

begin
  optparser.parse!
rescue => e
  puts e.class
  puts optparser
  exit
end


main = Hash.new(0)
ip_hash = Hash.new(0)

#finds each ip address from the command
array = command.split
ip = array.select {|i| i[/\d{2,}.\d{2,}.\d{2,}.\d{2,}/]}
puts ip

#counts frequencies of each ip address
ip_hash = Hash.new(0)
ip.each do |ip|
  ip_hash[ip] += 1
end

#test IPs
<<-TEST
puts "Frequency of Client IP Addresses:"
ip_hash.each do |k, v|
  #puts k.to_s.ljust(20) + " " + ("*" * v.to_i)
end
puts ""
TEST

stdout, stdeerr, status = Open3.capture3("#{command}") # get capture output of command executed


user_name = []
#gets each user name for use in getent
stdout.each_line do |line|
  user_name << line.split.first
end

user_name.each do |user|
  getent_line = `getent passwd #{user}`
  puts getent_line
end
