require "./liars_dice.rb"

a = LiarsDice.new
b = LiarsDice.new

puts a.sides.join ','
puts b.sides.join ','

puts a.tier, b.tier, a.subtier

puts a > b

a.reroll [:ace]

puts a.sides.join ','

puts a.value, b.value