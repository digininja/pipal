class List_Checker < Checker
	@list = {}

	def initialize
		super

		@include_context = false
		@cli_params = [['--list.inc_context', GetoptLong::NO_ARGUMENT]]
	end

	def usage
		return "\t--list.inc_context: include context for all list based checkers"
	end

	def parse_params opts
		opts.each do |opt, arg|
			case opt
				when '--list.inc_context'
					@include_context = true
			end
		end
	end

	def process_word (word, extras = nil)
		@list.each_pair do |list_word, match_data|
			if /#{list_word}/i.match word
				@list[list_word][:count] += 1
				if @include_context
					if not @list[list_word][:context].has_key? word
						@list[list_word][:context][word] = 0
					end
					@list[list_word][:context][word] += 1
				end
			end
		end
		@total_words_processed += 1
	end

	def get_results(title)
		ret_str = "#{title}\n"
		disp = false

		(@list.sort do |x,y| (x[1][:count] <=> y[1][:count]) * -1 end).each do |word_data|
			unless word_data[1] == 0
				disp = true
				ret_str << "#{word_data[0]} = #{word_data[1][:count].to_s} (#{((word_data[1][:count].to_f/@total_words_processed) * 100).round(2).to_s}%)"
				if @include_context
					ret_str << " - "
					word_data[1][:context].each_pair do |phrase, count|
						ret_str << "#{phrase} (#{count}), "
					end
					# remove the last comma and space
					ret_str = ret_str[0...-2]
				end
				ret_str << "\n"
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		return ret_str
	end
end
