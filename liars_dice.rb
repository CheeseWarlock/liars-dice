class LiarsDice
	TIERS = [:high, :pair, :two_pair, :three_of, :full_house, :four_of, :straight, :five_of]
	def initialize
		@sides = roll
	end

	def sides
		@sides
	end

	def roll(num=5)
		sides = [:nine, :ten, :jack, :queen, :king, :ace]
		Array.new(num) { sides.sample }
	end

	def reroll(values=[])
		values.each do |value|
			rerolled = @sides.find_index(value)
			@sides[rerolled] = roll(1)[0] if rerolled
		end
	end

	def tier
		@sides.map {|i| @sides.grep(i).length }.max
	end

	def subtier
		@sides.uniq.map {|i| @sides.grep(i).length }.sort[-2]
	end

	def value
		case self.tier
			when 5
				:five_of
			when 4
				:four_of
			when 3
				subtier == 2 ? :full_house : :three_of
			when 2
				subtier == 2 ? :two_pair : :pair
			else
				:high
		end
	end

	def >(other)
		self.tier > other.tier
	end

	def <(other)
		self.tier < other.tier
	end
end
