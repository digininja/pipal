# encoding: utf-8

# Find out what our base path is
base_path = File.expand_path(File.dirname(__FILE__))
require File.join(base_path, '../horizbar.rb')
register_checker("Basic_Checker")

class Basic_Checker < Checker
	FIRST_CAP_LAST_NUM_RE = /^[A-Z].*[0-9]$/
	FIRST_CAP_LAST_SYMBOL_RE = /^[A-Z].*[\p{Punct}]$/

	SINGLES_ON_END_RE = /[^0-9]+([0-9]{1})$/
	DOUBLES_ON_END_RE = /[^0-9]+([0-9]{2})$/
	TRIPLES_ON_END_RE =/[^0-9]+([0-9]{3})$/ 

	def initialize
		super

		@words = {}
		@one_to_six_chars = 0
		@one_to_eight_chars = 0
		@over_eight_chars = 0

		@lengths = []
		@max_length = 0
		@base_words = {}

		@first_cap_last_num = 0
		@first_cap_last_symbol = 0

		# this is the count of words with 1, 2 and 3 numbers on the end
		@singles_on_end = 0
		@doubles_on_end = 0
		@triples_on_end = 0
		
		# this is the actual last number on the end, single digit
		@last_on_end = []
		0.upto(4) do |no_of_digits|
			@last_on_end[no_of_digits] = {}
		end

		# last two and three numbers on the end
		@last_two_on_end = {}
		@last_three_on_end = {}

		@char_stats = {
		"loweralpha" => {'regex' => /^[a-z]+$/, "count" => 0},
		"upperalpha" => {'regex' => /^[A-Z]+$/, "count" => 0},
		"numeric" => {'regex' => /^[0-9]+$/, "count" => 0},
		"special" => {'regex' => /^[\p{Punct}]+$/, "count" => 0},

		"loweralphanum" => {'regex' => /^[a-z0-9]+$/, "count" => 0},
		"upperalphanum" => {'regex' => /^[A-Z0-9]+$/, "count" => 0},
		"mixedalpha" => {'regex' => /^[a-zA-Z]+$/, "count" => 0},
		"loweralphaspecial" => {'regex' => /^[a-z\p{Punct}]+$/, "count" => 0},
		"upperalphaspecial" => {'regex' => /^[A-Z\p{Punct}]+$/, "count" => 0},
		"specialnum" => {'regex' => /^[\p{Punct}0-9]+$/, "count" => 0},

		"mixedalphanum" => {'regex' => /^[a-zA-Z0-9]+$/, "count" => 0},
		"loweralphaspecialnum" => {'regex' => /^[a-z\p{Punct}0-9]+$/, "count" => 0},
		"mixedalphaspecial" => {'regex' => /^[A-Za-z\p{Punct}]+$/, "count" => 0},
		"upperalphaspecialnum" => {'regex' => /^[A-Z\p{Punct}0-9]+$/, "count" => 0},

		"mixedalphaspecialnum" => {'regex' => /^[A-Za-z\p{Punct}0-9]+$/, "count" => 0},
		}

		@char_sets_ordering = {
		"stringdigit" => {"regex" => /^[a-z]+[0-9]+$/, "count" => 0},
		"allstring" => {"regex" => /^[a-z]+$/, "count" => 0},
		"digitstring" => {"regex" => /^[0-9]+[a-z]+$/, "count" => 0},
		"stringdigitstring" => {"regex" => /^[a-z]+[0-9]+[a-z]+$/, "count" => 0},
		"alldigit" => {"regex" => /^[0-9]+$/, "count" => 0},
		"digitstringdigit" => {"regex" => /^[0-9]+[a-z]+[0-9]+$/, "count" => 0},
		"stringspecialdigit" => {"regex" => /^[a-z]+[\p{Punct}]+[0-9]+$/, "count" => 0},
		"stringspecialstring" => {"regex" => /^[a-z]+[\p{Punct}]+[a-z]+$/, "count" => 0},
		"stringspecial" => {"regex" => /^[a-z]+[\p{Punct}]+$/, "count" => 0},
		"specialstring" => {"regex" => /^[\p{Punct}]+[a-z]+$/, "count" => 0},
		"specialstringspecial" => {"regex" => /^[\p{Punct}]+[a-z]+[\p{Punct}]+$/, "count" => 0},
		"allspecial" => {"regex" => /^[\p{Punct}]+$/, "count" => 0},
		"othermask" => {"regex" => /^.*$/, "count" => 0}
		}


		@description = "Basic Checks"
	end

	def process_word (word, extras = nil)
		# don't think this is required any more
		# Doing this so that I can support a wider range of characters, a UK pound sign
		# breaks the app without it
		# line.force_encoding("ASCII-8BIT")

		if !@words.has_key?(word)
			@words[word] = 0
		end
		@words[word] += 1

		lower_word = word.downcase
		# strip any non-alpha from the start or end, I was going to strip all non-alpha
		# but then found a list with Unc0rn as a very common base. Stripping all non-alpha
		# would leave with Uncrn which doesn't really make any sense as without the 133t speak
		# it is out of context.
		#
		# If you want all non-alpha stripped use the following line instead
		#
		# word_just_alpha = lower_word.gsub(/[^a-z]*/, "")
		#
		word_just_alpha = lower_word.gsub(/^[^a-z]*/, "").gsub(/[^a-z]*$/, '')
		if word_just_alpha.length > 3
			if !@base_words.has_key?(word_just_alpha)
				@base_words[word_just_alpha] = 0
			end
			@base_words[word_just_alpha] += 1
		end

		if @lengths[word.length].nil?
			@lengths[word.length] = 0
		end
		@lengths[word.length] += 1

		if word.length < 9
			@one_to_eight_chars += 1
		end

		if word.length < 7
			@one_to_six_chars += 1
		end

		if word.length > 8
			@over_eight_chars += 1
		end

		if word =~ FIRST_CAP_LAST_SYMBOL_RE
			@first_cap_last_symbol += 1
		end

		if word =~ FIRST_CAP_LAST_NUM_RE
			@first_cap_last_num += 1
		end

		if word =~ SINGLES_ON_END_RE
			@singles_on_end += 1
		end
		
		# Can't merge these two as the first is strict, 2 digits on the end, the second 
		# just wants the last two digits regardless
		if word =~ DOUBLES_ON_END_RE
			@doubles_on_end += 1
		end

		if word =~ TRIPLES_ON_END_RE
			@triples_on_end += 1
		end
		
		1.upto(5) do |no_of_digits|
			if /([0-9]{#{no_of_digits}})$/.match word
				last_numbers = $1
				if !@last_on_end[no_of_digits - 1].has_key?(last_numbers)
					@last_on_end[no_of_digits - 1][last_numbers] = 0
				end
				@last_on_end[no_of_digits - 1][last_numbers] += 1
			end

		end
		
		@char_stats.each_pair do |name, data|
			begin
				if word =~ data['regex']
					@char_stats[name]['count'] += 1
					break
				end
			rescue Encoding::CompatibilityError
				puts "Encoding problem found with password: " + word
			end
		end

		@char_sets_ordering.each_pair do |name, data|
			begin
				if lower_word =~ data['regex']
					@char_sets_ordering[name]['count'] += 1
					break
				end
			rescue Encoding::CompatibilityError
				puts "Encoding problem found with password: " + word
			end
		end
		@total_words_processed += 1
	end

	def get_results()
		data = get_json_results
		total_words_processed = data['Total_entries']
		ret_str = "Basic Results\n\n"
		ret_str <<  "Total entries = #{data['Total_entries']}\n"
		ret_str << "Total unique entries = #{data['Total_unique_entries']}\n"

		ret_str << "\nTop #{@cap_at} passwords\n"
		ret_str << print_entries(data["Top_#{@cap_at.to_s}_passwords"])

		ret_str << "\nTop #{@cap_at.to_s} base words\n"
		ret_str << print_entries(data["Top_#{@cap_at.to_s}_base_words"])

		ret_str << "\nPassword length (length ordered)\n"
		ret_str << print_entries(data['Password_length'])

		ret_str << "\nPassword length (count ordered)\n"
		ret_str << print_entries(data['Password_length'].sort{|a,b|(b[1]['count'] <=> a[1]['count'])})

		ret_str << "\n"

		lengths = []
		data['Password_length'].each {|pwd|
			lengths << pwd[1]['count']
		}
		horiz = HorizBar.new(lengths)
		horiz.generate
		ret_str << horiz.graph


		ret_str << "\nOne to six characters = #{data['One_to_six_characters']['count']} (#{data['One_to_six_characters']['percentage']}%)\n"
		ret_str << "One to eight characters = #{data['One_to_eight_characters']['count']} (#{data['One_to_eight_characters']['percentage']}%)\n"
		ret_str << "More than eight characters = #{data['More_than_eight_characters']['count']} (#{data['More_than_eight_characters']['percentage']}%)\n"

		ret_str << "\nOnly lowercase alpha = #{data['Only_lowercase_alpha']['count']} (#{data['Only_lowercase_alpha']['percentage']}%)\n"
		ret_str << "Only uppercase alpha = #{data['Only_uppercase_alpha']['count']} (#{data['Only_uppercase_alpha']['percentage']}%)\n"
		ret_str << "Only alpha = #{data['Only_alpha']['count']} (#{data['Only_alpha']['percentage']}%)\n"

		ret_str << "Only numeric = #{data['Only_numeric']['count']} (#{data['Only_numeric']['percentage']}%)\n"

		ret_str << "\nFirst capital last symbol = #{data['First_capital_last_symbol']['count']} (#{data['First_capital_last_symbol']['percentage']}%)\n"
		ret_str << "First capital last number = #{data['First_capital_last_number']['count']} (#{data['First_capital_last_number']['percentage']}%)\n"

		ret_str << "\nSingle digit on the end = #{data['Single_digit_on_the_end']['count']} (#{data['Single_digit_on_the_end']['percentage']}%)\n"
		ret_str << "Two digits on the end = #{data['Two_digits_on_the_end']['count']} (#{data['Two_digits_on_the_end']['percentage']}%)\n"
		ret_str << "Three digits on the end = #{data['Three_digits_on_the_end']['count']} (#{data['Three_digits_on_the_end']['percentage']}%)\n"

		ret_str << "\nLast number\n"
		ret_str << print_entries(data['Last_digit'].sort{|a,b|(a[0] <=> b[0])})

		digits = []
		data['Last_digit'].sort{|a,b|(a[0] <=> b[0])}.each {|pwd|
			digits << pwd[1]['count']
		}

		disp = !data['Last_digit'].empty?
		if disp
			ret_str << "\n"
			horiz = HorizBar.new(digits)
			horiz.generate
			ret_str << horiz.graph
			else
			ret_str << "None found\n"
		end

		ret_str << "\nLast digit\n"
		ret_str << print_entries(data['Last_digit'])

		2.upto(10) do |len|
			digits = data["Last_#{len}_digits_(Top_#{@cap_at.to_s})"]
			if !digits.nil?
				ret_str << "\nLast #{len} digits (Top #{@cap_at.to_s})\n"
				ret_str << print_entries(digits)
			end
		end

		ret_str << "\nCharacter sets\n"
		ret_str << print_entries(data['Character_sets'])

		ret_str << "\nCharacter set ordering\n"
		ret_str << print_entries(data['Character_set_ordering'])

		return ret_str
	end

	def get_json_results()
		result = {}
		result['Total_entries'] = @total_words_processed
		uniq_words = @words.to_a.uniq
		result['Total_unique_entries'] = uniq_words.length

		top_ten = {}
		@words.sort{|a,b| (a[1]<=>b[1]) * -1}[0, @cap_at].each { |elem|
			percentage = (elem[1].to_f / @total_words_processed) * 100
			top_ten[elem[0]] = {'count'=>elem[1],'percentage'=>percentage.round(2)}
		}
		result["Top_#{@cap_at.to_s}_passwords"] = top_ten

		top_base = {}
		# ret_str << "\nTop #{@cap_at.to_s} base words\n"
		@base_words.sort{|a,b| (a[1]<=>b[1]) * -1}[0, @cap_at].each { |elem|
			percentage = (elem[1].to_f / @total_words_processed) * 100
			top_base[elem[0]] = {'count'=>elem[1],'percentage'=>percentage.round(2)}
		}
		result["Top_#{@cap_at.to_s}_base_words"] = top_base

		length_json = {}
		length_ordered = []
		0.upto(@lengths.count - 1) do |len|
			if @lengths[len].nil?
				@lengths[len] = 0
			end
			percentage = ((@lengths[len].to_f / @total_words_processed) * 100)
			length_json[len] = {'count'=>@lengths[len],'percentage'=>percentage.round(2)} if @lengths[len] > 0
			
			pair = [len, @lengths[len], percentage]
			length_ordered << pair
		end
		result['Password_length'] = length_json

		result['One_to_six_characters']      = {'count'=>@one_to_six_chars,'percentage'=> ((@one_to_six_chars.to_f/@total_words_processed) * 100).round(2)}
		result['One_to_eight_characters']    = {'count'=>@one_to_eight_chars,'percentage'=>((@one_to_eight_chars.to_f/@total_words_processed) * 100).round(2)}
		result['More_than_eight_characters'] = {'count'=>@over_eight_chars,'percentage'=>((@over_eight_chars.to_f/@total_words_processed) * 100).round(2)}

		result['Only_lowercase_alpha'] = {'count'=> @char_stats['loweralpha']['count'],'percentage'=> ((@char_stats['loweralpha']['count'].to_f/@total_words_processed) * 100).round(2)}
		result['Only_uppercase_alpha'] = {'count'=> @char_stats['upperalpha']['count'] , 'percentage' => ((@char_stats['upperalpha']['count'].to_f/@total_words_processed) * 100).round(2)}
		result['Only_alpha'] = {'count' => (@char_stats['upperalpha']['count'] + @char_stats['loweralpha']['count']) , 'percentage' => (((@char_stats['upperalpha']['count'] + @char_stats['loweralpha']['count']).to_f/@total_words_processed) * 100).round(2)}

		result['Only_numeric'] = {'count' => @char_stats['numeric']['count'] , 'percentage' => ((@char_stats['numeric']['count'].to_f/@total_words_processed) * 100).round(2)}

		result['First_capital_last_symbol'] = {'count' => @first_cap_last_symbol , 'percentage' => ((@first_cap_last_symbol.to_f/@total_words_processed) * 100).round(2)}
		result['First_capital_last_number'] = {'count' => @first_cap_last_num , 'percentage' => ((@first_cap_last_num.to_f/@total_words_processed) * 100).round(2)}

		result['Single_digit_on_the_end'] = {'count' => @singles_on_end , 'percentage' => ((@singles_on_end.to_f/@total_words_processed) * 100).round(2)}
		result['Two_digits_on_the_end'] = {'count' => @doubles_on_end , 'percentage' => ((@doubles_on_end.to_f/@total_words_processed) * 100).round(2)}
		result['Three_digits_on_the_end'] = {'count' => @triples_on_end , 'percentage' => ((@triples_on_end.to_f/@total_words_processed) * 100).round(2)}

		digit_number = 0
		@last_on_end.each do |a|
			c = a.to_a.sort do |x,y|
				(x[1] <=> y[1]) * -1
			end

			digit_number += 1
			if c.count > 0
				digits = {}
				c[0, @cap_at].each do |d|
					digits[d[0]] = {'count' => d[1], 'percentage' => ((d[1].to_f/@total_words_processed) * 100).round(2)}
				end

				if (digit_number == 1)
					result['Last_digit'] = digits
				else
					result["Last_" + digit_number.to_s + "_digits_(Top_" + @cap_at.to_s + ")"] = digits
				end

			end
		end

		count_ordered = []
		@char_stats.each_pair do |name, data|
			count_ordered << [name, data] unless data['count'].zero?
		end
		@char_stats = count_ordered.sort do |x,y|
			(x[1]['count'] <=> y[1]['count']) * -1
		end

		char_sets = {}
		@char_stats.each do |name, data|
			char_sets[name] = {'count'=> data['count'], 'percentage' => ((data['count'].to_f/@total_words_processed) * 100).round(2)}
		end
		result['Character_sets'] = char_sets

		count_ordered = []
		@char_sets_ordering.each_pair do |name, data|
			count_ordered << [name, data] unless data['count'].zero?
		end
		@char_sets_ordering = count_ordered.sort do |x,y|
			(x[1]['count'] <=> y[1]['count']) * -1
		end

		char_sets_order = {}
		@char_sets_ordering.each do |name, data|
			char_sets_order[name] = {'count'=> data['count'], 'percentage' => ((data['count'].to_f/@total_words_processed) * 100).round(2)}
		end
		result['Character_set_ordering'] = char_sets_order
		
		return result
	end
end
