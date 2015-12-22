class List_Checker < Checker
	@list = {}

	def initialize
		super
	end

	def process_word (word, extras = nil)
		@list.each_pair do |word, count|
			if /#{word}/i.match word
				@list[word] += 1
			end
		end
		@total_words_processed += 1
	end

	def get_results(title)
		ret_str = "#{title}\n"
		disp = false

		(@list.sort do |x,y| (x[1] <=> y[1]) * -1 end).each do |word_data|
			unless word_data[1] == 0
				disp = true
				ret_str << "#{word_data[0]} = #{word_data[1].to_s} (#{((word_data[1].to_f/@total_words_processed) * 100).round(2).to_s}%)\n"
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		return ret_str
	end
end
