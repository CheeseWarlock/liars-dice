require "./liars_dice.rb"

dice = LiarsDice.new
5.times do |_|
	dice.reroll_all
	puts dice.to_s
	puts "------"
end