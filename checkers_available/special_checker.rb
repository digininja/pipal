# encoding: utf-8
#
# Work in progress to count special characters used across all passwords
#

# Find out what our base path is
base_path = File.expand_path(File.dirname(__FILE__))
require File.join(base_path, '../horizbar.rb')
register_checker("Special_Checker")

class Special_Checker < Checker
	@list = {}

	def initialize
		super
		@list = {}
	end

	def process_word (word, extras = nil)
		word.each_char do |letter|
			if letter !~ /[a-z 0-9]/i
				if not @list.has_key? letter
					@list[letter] = 0
				end
				@list[letter] += 1
			end
		end
		@total_words_processed += 1
	end

	def get_results()
		data = get_json_results
		ret_str = "Special Checker\n"
		disp = !data.nil?

		if disp 
			ret_str << print_entries(data)
		else
			ret_str << "None found\n"
		end

		return ret_str
	end

	def get_json_results()
		result = {}

		(@list.sort do |x,y| (x[1] <=> y[1]) * -1 end).each do |special_data|
			unless special_data[1].zero?
				result[special_data[0]] = { 'count' => special_data[1], 'percentage' => ((special_data[1].to_f/@total_words_processed) * 100).round(2) }
			end
		end

		return result
	end

end
