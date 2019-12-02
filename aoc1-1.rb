#!/usr/bin/env ruby

# frozen_string_literal: true

# --- Day 1: The Tyranny of the Rocket Equation ---
#
# Santa has become stranded at the edge of the Solar System while delivering presents to other planets! To
# accurately calculate his position in space, safely align his warp drive, and return to Earth in time to save
# Christmas, he needs you to bring him measurements from fifty stars.
#
# Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the
# second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!
#
# The Elves quickly load you into a spacecraft and prepare to launch.
#
# At the first Go / No Go poll, every Elf is Go until the Fuel Counter-Upper. They haven't determined the amount of fuel required yet.
#
# Fuel required to launch a given module is based on its mass. Specifically, to find the fuel required for a
# module, take its mass, divide by three, round down, and subtract 2.
#
# For example:
#
#     For a mass of 12, divide by 3 and round down to get 4, then subtract 2 to get 2.
#     For a mass of 14, dividing by 3 and rounding down still yields 4, so the fuel required is also 2.
#     For a mass of 1969, the fuel required is 654.
#     For a mass of 100756, the fuel required is 33583.
#
# The Fuel Counter-Upper needs to know the total fuel requirement. To find it, individually calculate the fuel
# needed for the mass of each module (your puzzle input), then add together all the fuel values.
#
# What is the sum of the fuel requirements for all of the modules on your spacecraft?

# Mass, divided by three, rounded down, and subtract two.
# Ruby integer division rounds down for us already.
def fuel(mass)
  f = (mass / 3).to_i - 2
  f.positive? ? f : 0
end

print 'Testing the Fuel Counter-Upper... '
tests = { 12 => 2, 12.1 => 2, 14 => 2, 1_969 => 654, 100_756 => 33_583, 1 => 0 }

if tests.all? { |m, f| fuel(m) == f }
  puts 'Go!'
else
  puts 'No go!'
  exit(1)
end

payload_fuel = File.open('./aoc1.txt', 'r').map do |line|
  mass = line.to_i
  next if mass.zero?

  fuel(mass)
end.compact.sum

puts "Fuel required: #{payload_fuel}"
