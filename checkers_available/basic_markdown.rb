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
		ret_str = "# Basic Results\n\n"
		ret_str <<  "- Total entries = #{@total_words_processed.to_s}\n"
		uniq_words = @words.to_a.uniq
		ret_str << "- Total unique entries = #{uniq_words.length.to_s}\n"
		uniq_words = Array.new(@words.to_a.uniq)

		ret_str << "\n## Top #{@cap_at.to_s} passwords\n\n"
		# The default is to sort lowest to highest, the -1 just inverts that
		@words.sort{|a,b| (a[1]<=>b[1]) * -1}[0, @cap_at].each { |elem|
			percentage = (elem[1].to_f / @total_words_processed) * 100
			ret_str << "1. #{elem[0]} = #{elem[1].to_s} (#{percentage.round(2).to_s}%)\n"
		}

		ret_str << "\n## Top #{@cap_at.to_s} base words\n\n"
		@base_words.sort{|a,b| (a[1]<=>b[1]) * -1}[0, @cap_at].each { |elem|
			percentage = (elem[1].to_f / @total_words_processed) * 100
			ret_str << "1. #{elem[0]} = #{elem[1].to_s} (#{percentage.round(2).to_s}%)\n"
		}

		ret_str << "\n## Length Data\n"

		ret_str << "\n- One to six characters = #{@one_to_six_chars.to_s} (#{((@one_to_six_chars.to_f/@total_words_processed) * 100).round(2).to_s}%)\n"
		ret_str << "- One to eight characters = #{@one_to_eight_chars.to_s} (#{((@one_to_eight_chars.to_f/@total_words_processed) * 100).round(2).to_s}%)\n"
		ret_str << "- More than eight characters = #{@over_eight_chars.to_s} (#{((@over_eight_chars.to_f/@total_words_processed) * 100).round(2).to_s}%)\n"

		ret_str << "\n### Length Ordered\n\n"

		length_ordered = []
		0.upto(@lengths.count - 1) do |len|
			if @lengths[len].nil?
				@lengths[len] = 0
			end
			percentage = ((@lengths[len].to_f / @total_words_processed) * 100)
			ret_str << "1. #{len.to_s} = #{@lengths[len].to_s} (#{percentage.round(2).to_s}%)\n" if @lengths[len] > 0
			
			pair = [len, @lengths[len], percentage]
			length_ordered << pair
		end

		length_ordered.sort! do |x,y|
			y[1] <=> x[1]
		end

		ret_str << "\n### Count Ordered\n\n"
		length_ordered.each do |pair|
			ret_str << "1. #{pair[0].to_s} = #{pair[1].to_s} (#{pair[2].round(2).to_s}%)\n" if pair[1] > 0
		end
		ret_str << "\n"

		horiz = HorizBar.new(@lengths)
		horiz.generate
        ret_str << "```Text\n"
		ret_str << horiz.graph
        ret_str << "```\n"

		ret_str << "\n## Structure\n"
		ret_str << "\n- Only lowercase alpha = " + @char_stats['loweralpha']['count'].to_s + ' (' + ((@char_stats['loweralpha']['count'].to_f/@total_words_processed) * 100).round(2).to_s + "%)\n"
		ret_str << "- Only uppercase alpha = " + @char_stats['upperalpha']['count'].to_s + ' (' + ((@char_stats['upperalpha']['count'].to_f/@total_words_processed) * 100).round(2).to_s + "%)\n"
		ret_str << "- Only alpha = " + (@char_stats['upperalpha']['count'] + @char_stats['loweralpha']['count']).to_s + ' (' + (((@char_stats['upperalpha']['count'] + @char_stats['loweralpha']['count']).to_f/@total_words_processed) * 100).round(2).to_s + "%)\n"
		ret_str << "- Only numeric = " + @char_stats['numeric']['count'].to_s + ' (' + ((@char_stats['numeric']['count'].to_f/@total_words_processed) * 100).round(2).to_s + "%)\n"

		ret_str << "\n<!-- -->\n"

		ret_str << "\n- First capital last symbol = " + @first_cap_last_symbol.to_s + ' (' + ((@first_cap_last_symbol.to_f/@total_words_processed) * 100).round(2).to_s + "%)\n"
		ret_str << "- First capital last number = " + @first_cap_last_num.to_s + ' (' + ((@first_cap_last_num.to_f/@total_words_processed) * 100).round(2).to_s + "%)\n"

		ret_str << "\n<!-- -->\n"

		ret_str << "\n- Single digit on the end = " + @singles_on_end.to_s + ' (' + ((@singles_on_end.to_f/@total_words_processed) * 100).round(2).to_s + "%)\n"
		ret_str << "- Two digits on the end = " + @doubles_on_end.to_s + ' (' + ((@doubles_on_end.to_f/@total_words_processed) * 100).round(2).to_s + "%)\n"
		ret_str << "- Three digits on the end = " + @triples_on_end.to_s + ' (' + ((@triples_on_end.to_f/@total_words_processed) * 100).round(2).to_s + "%)\n"

		ret_str << "\n### Last Number\n\n"
		disp = false

		graph_numbers = {0=>0, 1=>0, 2=>0, 3=>0, 4=>0, 5=>0, 6=>0, 7=>0, 8=>0, 9=>0}

		c = @last_on_end[0].to_a.sort do |x,y|
			(x[0] <=> y[0])
		end

		c.each do |number, count|
			unless count == 0
				disp = true
				ret_str << "- " + number.to_s + " = " + count.to_s + ' (' + ((count.to_f/@total_words_processed) * 100).round(2).to_s + "%)\n" unless count == 0
			end
			graph_numbers[number.to_i] = count

		end
		if  disp
			ret_str << "\n"
			horiz = HorizBar.new(graph_numbers.values)
			horiz.generate
            ret_str << "```Text\n"
            ret_str << horiz.graph
            ret_str << "```\n"
		else
			ret_str << "None found\n"
		end

		digit_number = 0
		@last_on_end.each do |a|
			c = a.to_a.sort do |x,y|
				(x[1] <=> y[1]) * -1
			end

			digit_number += 1
			if c.count > 0
				if (digit_number == 1)
					ret_str << "\n### Last digit\n\n"
				else
					ret_str << "\n### Last " + digit_number.to_s + " digits (Top " + @cap_at.to_s + ")\n\n"
				end

				c[0, @cap_at].each do |d|
					ret_str << "- " + d[0] + " = " + d[1].to_s + ' (' + ((d[1].to_f/@total_words_processed) * 100).round(2).to_s + "%)\n"
				end
			end
		end

		count_ordered = []
		@char_stats.each_pair do |name, data|
			count_ordered << [name, data] unless data['count'] == 0
		end
		@char_stats = count_ordered.sort do |x,y|
			(x[1]['count'] <=> y[1]['count']) * -1
		end

		ret_str << "\n## Character sets\n\n"
		@char_stats.each do |name, data|
			ret_str << "- " + name + ": " + data['count'].to_s + " (" + ((data['count'].to_f/@total_words_processed) * 100).round(2).to_s + "%)\n"
		end

		count_ordered = []
		@char_sets_ordering.each_pair do |name, data|
			count_ordered << [name, data] unless data['count'] == 0
		end
		@char_sets_ordering = count_ordered.sort do |x,y|
			(x[1]['count'] <=> y[1]['count']) * -1
		end

		ret_str << "\n### Character set ordering\n\n"
		@char_sets_ordering.each do |name, data|
			ret_str << "- " + name + ": " + data['count'].to_s + " (" + ((data['count'].to_f/@total_words_processed) * 100).round(2).to_s + "%)\n"
		end

		return ret_str
	end
end
