require "./liars_dice.rb"

a = LiarsDice.new
b = LiarsDice.new

puts a.sides.join ','
puts b.sides.join ','

puts a.tier, b.tier

puts a > b