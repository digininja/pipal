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

	def parse_params opts
	end

	def process_word (word, extras = nil)
	end

	def get_results (total_words_processed)
	end
end
