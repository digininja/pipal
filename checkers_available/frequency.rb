# encoding: utf-8

# Find out what our base path is
base_path = File.expand_path(File.dirname(__FILE__))
require File.join(base_path, '../horizbar.rb')
register_checker("Frequency_Checker")

class Frequency_Checker < Checker

	def initialize
		super
		@description = "Count the frequency of characters in each position, output as either CSV or text"

		@frequencies = []
		@position_count = []

		@show_empty = false
		@as_csv = false

		@cli_params = [['--freq.show_empty', GetoptLong::NO_ARGUMENT], ['--freq.as_csv', GetoptLong::NO_ARGUMENT]]
	end

	def usage
		ret_str = "\t--freq.show_empty: show empty frequencies - does not apply to CSV\n"
		ret_str << "\t--freq.as_csv: output in CSV format"
		return ret_str
	end

	def parse_params opts
		opts.each do |opt, arg|
			case opt
				when '--freq.as_csv'
					@as_csv = true
				when '--freq.show_empty'
					@show_empty = true
			end
		end
	end


	def setup_new_frequency position 
		@frequencies[position] = {}

		alphabet = "0123456789abcčćđdefghijklmnopqrsštuvwxyzžABCČĆDĐEFGHIJKLMNOPQRSŠTUVWXYZŽ !\"\#$%&'()*+,-./:;<=>?@[\\]^_`{|}~äüęé"
		alphabet.each_char do |a|
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
		if @as_csv then
			if @frequencies.count == 0 then
				ret_str = "No data collected"
			else
				ret_str = ""
				
				header = '"Position","' + @frequencies[0].keys.join('","') + '"'
				header.gsub! /"""/,'"<quote>"'
				ret_str << header + "\n"
				ret_str << "Count\n"

				position = 0
				@frequencies.each do |data|
					ret_str << position.to_s + "," + data.values.join(',')
					ret_str << "\n"
					position += 1
				end
				ret_str << "\n\n\n"
				ret_str << "Percentage\n"

				position = 0
				@frequencies.each do |data|
					ret_str << position.to_s + ","
					@frequencies[position].each_pair do |key, count|
						ret_str << ((count.to_f/@position_count[position]) * 100).round(2).to_s + ","
					end
					ret_str << "\n"
					position += 1
				end
			end
		else
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
		end

		return ret_str

		return ret_str
	end
end
