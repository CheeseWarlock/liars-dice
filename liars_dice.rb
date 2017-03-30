class LiarsDice
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
end
