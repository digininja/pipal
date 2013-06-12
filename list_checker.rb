class List_Checker < Checker
	@list = {}

	def initialize
		super
	end

	def process_word (word, extras = nil)
		@list.each_pair do |colour, count|
			if /#{colour}/i.match word
				@list[colour] += 1
			end
		end
		@total_words_processed += 1
	end

	def get_results(title)
		ret_str = "#{title}\n"
		disp = false

		(@list.sort do |x,y| (x[1] <=> y[1]) * -1 end).each do |colour_data|
			unless colour_data[1] == 0
				disp = true
				ret_str << "#{colour_data[0]} = #{colour_data[1].to_s} (#{((colour_data[1].to_f/@total_words_processed) * 100).round(2).to_s}%)\n"
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		return ret_str
	end
end
