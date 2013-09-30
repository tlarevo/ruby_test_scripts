#!/usr/bin/env ruby

plastic_cup = nil

if plastic_cup
	puts "Cup is not empty"
else
	puts "Cup is empty"
end

puts "Tell me your evil plan"
evil_plan = gets.upcase.reverse
puts "your plan is screwed"
puts evil_plan
