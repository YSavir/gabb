require 'colorize'
require 'pry'
require_relative 'gabb'

puts "Greetings, WDI Student. Welcome to our bug solving session!".blue
puts "This exercise will explore a few ruby errors and how to solve them.".blue
print "Are you ready? Press Enter to proceed.".blue

gets.chomp
puts "\n\nWe're going to start by getting a method that prints 'hi' to the screen.".blue
puts "The code for this method is found in another file. We'll have to require it before we can use the code.".blue
puts "Press Enter to require the code.".blue
gets.chomp

gabb = nil
begin
  require_relative 'exercises/puts_hi'
rescue SyntaxError => error
  puts (error.to_s + "\n").colorize(:yellow)
  gabb = Gabb.new(error)
  gabb.find_details
  gabb.validate_details
  puts "Great. Go to that file and fix the issue.".blue
  puts "Then press Enter.".blue
  gets.chomp
  retry
else
  gabb.log_error
  puts "Problem fixed!".blue
  puts "Can you give me a brief explanation of what you did? Enter 'q' to exit.".blue
  f = File.open('log.txt', 'a')
  f.puts "Solution: "
  f.puts gets.chomp
  f.close
end

