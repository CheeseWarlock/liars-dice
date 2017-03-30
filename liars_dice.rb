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

	def tier
		@sides.map {|i| @sides.grep(i).length }.max
	end

	def >(other)
		self.tier > other.tier
	end

	def <(other)
		self.tier < other.tier
	end
end
