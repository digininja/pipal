# encoding: utf-8

# Find out what our base path is
base_path = File.expand_path(File.dirname(__FILE__))
require File.join(base_path, '../horizbar.rb')
register_checker("Frequency_Checker")

class Frequency_Checker < Checker

	def initialize
		super
		@description = "Frequency Checks"

		@frequencies = []
		@position_count = []

		@show_empty = false

		@cli_params = [['--freq.show_empty', GetoptLong::NO_ARGUMENT]]
	end

	def usage
		return "\t--freq.show_empty: show empty frequencies"
	end

	def parse_params opts
		opts.each do |opt, arg|
			case opt
				when '--freq.show_empty'
					@show_empty = true
			end
		end
	end


	def setup_new_frequency position 
		@frequencies[position] = {}

		"a".upto("z") do |a|
			@frequencies[position][a] = 0
		end

		"A".upto("Z") do |a|
			@frequencies[position][a] = 0
		end

		"0".upto("9") do |a|
			@frequencies[position][a] = 0
		end

		punct = "!\"$%^&*()-=_+[]{};':@,.<>"
		punct.each_char do |a|
			@frequencies[position][a] = 0
		end

		@frequencies[position]["other"] = 0
	end

	def process_word (word, extras = nil)
		position = 0

		word.each_char do |char|
			if @frequencies[position].nil?
				self.setup_new_frequency position
			end

			if @frequencies[position].has_key?(char)
				@frequencies[position][char] += 1
			else
				@frequencies[position]["other"] += 1
			end

			if @position_count[position].nil?
				@position_count[position] = 0
			end
			@position_count[position] += 1

			position += 1
		end
	end

	def get_results()
		ret_str = "Frequency Results\n"
		ret_str << "-----------------\n"
		
		position = 0
		@frequencies.each do |data|
			ret_str << "position: #{position} - #{@position_count[position]} character#{(@position_count[position]>1)?'s':''}\n"
			@frequencies[position].each_pair do |key, count|
				if (@show_empty or count != 0)
					ret_str << "#{key}: #{count} (#{(count.to_f/@position_count[position]) * 100}%) "
				end
			end
		#	ret_str << @frequencies[position].inspect
			ret_str << "\n"
			position += 1
		end
		ret_str << "\n"

		return ret_str
	end
end
