class Checker
	attr_writer :cap_at
	attr_reader :description
	attr_reader :cli_params
	attr_writer :verbose

	def initialize
		@cap_at = 10
		@total_words_processed = 0
		@description = "No description given"
		@cli_params = nil
		@verbose = false
	end

	# Return any extra usage parameters added by the checker
	def usage
		return nil
	end

	def parse_params opts
	end

	def process_word (word, extras = nil)
	end

	def get_results (total_words_processed)
	end

	def get_json_results ()
	end

	def print_entries(entries)
		ret_str = ''
		entries.each do |k, v|
			ret_str << "#{k} = #{v['count']} (#{v['percentage']}%)\n"
		end
		return ret_str
	end
end
