class LiarsDice
	TIERS = [:high, :pair, :two_pair, :three_of, :full_house, :four_of, :straight, :five_of]
	SIDES = [:nine, :ten, :jack, :queen, :king, :ace]

	def initialize
		reroll_all
	end

	def sides
		@sides
	end

	def roll(num=5)
		Array.new(num) { SIDES.sample }
	end

	def reroll(values=[])
		values.each do |value|
			rerolled = @sides.find_index(value)
			@sides[rerolled] = roll(1)[0] if rerolled
		end
	end

	def reroll_all
		@sides = roll
	end

	def freqs
		@sides.uniq.map {|i| [i, @sides.grep(i).length] }.sort do |a, b|
			if (b[1] <=> a[1]) != 0
				b[1] <=> a[1]
			else
				SIDES.find_index(b[0]) <=> SIDES.find_index(a[0])
			end
		end
	end

	def value
		tier = self.freqs[0]
		subtier = self.freqs[1]
		case tier[1]
			when 5
				:five_of
			when 4
				:four_of
			when 3
				subtier == 2 ? :full_house : :three_of
			when 2
				subtier == 2 ? :two_pair : :pair
			when 1
				:high
		end
	end

	def to_s
		self.freqs.map do |i|
			i[1].to_s + " " + i[0].to_s
		end.join ", "
	end

	def >(other)
		self.tier > other.tier
	end

	def <(other)
		self.tier < other.tier
	end
end
