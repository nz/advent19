#!/usr/bin/env ruby

# frozen_string_literal: true

# --- Part Two ---
#
# During the second Go / No Go poll, the Elf in charge of the Rocket Equation Double-Checker stops the launch
# sequence. Apparently, you forgot to include additional fuel for the fuel you just added.
#
# Fuel itself requires fuel just like a module - take its mass, divide by three, round down, and subtract 2.
# However, that fuel also requires fuel, and that fuel requires fuel, and so on. Any mass that would require
# negative fuel should instead be treated as if it requires zero fuel; the remaining mass, if any, is instead
# handled by wishing really hard, which has no mass and is outside the scope of this calculation.
#
# So, for each module mass, calculate its fuel and add it to the total. Then, treat the fuel amount you just
# calculated as the input mass and repeat the process, continuing until a fuel requirement is zero or
# negative. For example:
#
#     A module of mass 14 requires 2 fuel. This fuel requires no further fuel (2 divided by 3 and rounded down
#     is 0, which would call for a negative fuel), so the total fuel required is still just 2.
#
#     At first, a module of mass 1969 requires 654 fuel. Then, this fuel requires 216 more fuel (654 / 3 - 2).
#     216 then requires 70 more fuel, which requires 21 fuel, which requires 5 fuel, which requires no further
#     fuel. So, the total fuel required for a module of mass 1969 is 654 + 216 + 70 + 21 + 5 = 966.
#
#     The fuel required by a module of mass 100756 and its fuel is: 33583 + 11192 + 3728 + 1240 + 411 + 135 +
#     43 + 12 + 2 = 50346.
#
# What is the sum of the fuel requirements for all of the modules on your spacecraft when also taking into
# account the mass of the added fuel? (Calculate the fuel requirements for each module separately, then add
# them all up at the end.)

def payload_fuel(mass)
  f = (mass / 3).to_i - 2
  f.positive? ? f : 0
end

def total_fuel(mass)
  total = 0
  loop do
    fuel = payload_fuel(mass)
    break if fuel.zero?

    total += fuel
    mass = fuel
  end
  total
end

puts 'Initializing Rocket Equation Double-Checker...'
puts payload_fuel(14)    == 2
puts total_fuel(14)      == 2
puts payload_fuel(1_969) == 654
puts total_fuel(1_969)   == 966
puts total_fuel(100_756) == 50_346

total_fuel = File.open('./aoc1.txt', 'r').map do |line|
  mass = line.to_i
  next if mass.zero?

  total_fuel(mass)
end.compact.sum

puts "Total fuel requirement: #{total_fuel}"
