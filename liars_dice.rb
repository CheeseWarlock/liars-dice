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
		freqs = self.freqs
		first = freqs[0][0]
		second = freqs[1][0]
		high = [:high, freqs.select { |i| i[1] == 1 }[0][0]]
		case freqs[0][1]
			when 5
				[[:five_of, first]]
			when 4
				[[:four_of, first], high]
			when 3
				freqs[1][1] == 2 ? [[:full_house, first, second]] : [[:three_of, first], high]
			when 2
				freqs[1][1] == 2 ? [[:two_pair, first, second], high] : [[:pair, first], high]
			when 1
				[high]
		end
	end

	def to_s
		self.value.map do |i|
			i[0].to_s + " " + (i[1..-1].join " and ")
		end.join ", "
	end

	def >(other)
		a = self.value
		b = other.value
		tier_diff = TIERS.find_index(a[0][0]) <=> TIERS.find_index(b[0][0])
		return tier_diff > 0 if tier_diff != 0
		side_diff = SIDES.find_index(a[0][1]) <=> SIDES.find_index(b[0][1])
		return tier_diff > 0 if side_diff != 0
		if a[0][0] == :full_house || a[0][0] == :two_pair
			side_diff = SIDES.find_index(a[0][2]) <=> SIDES.find_index(b[0][2])
			return tier_diff > 0 if side_diff != 0
		end
		side_diff = SIDES.find_index(a[1][1]) <=> SIDES.find_index(b[1][1])
		return tier_diff > 0 if side_diff != 0
		false
	end
end
