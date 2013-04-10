#!/usr/bin/env ruby

# == Pipal: Statistical analysis on password dumps
# 
# == Usage
#
# Usage: pipal [OPTION] ... FILENAME
#	--help, -h: show help
#	--top, -t X: show the top X results (default 10)
#	--output, -o <filename>: output to file
#	--external, -e <filename>: external file to compare words against
#	--gkey <Google Maps API key>: to allow zip code lookups (optional)
#
#	FILENAME: The file to count
#
# Author:: Robin Wood (robin@digininja.org)
# Copyright:: Copyright (c) Robin Wood 2013
# Licence:: Creative Commons Attribution-Share Alike 2.0
# Speedbumped by Stefan Venken (stefan.venken@gmail.com)
#

require 'benchmark'
require 'getoptlong'
require'net/http'
require'uri'
require'json'
require_relative './horizbar'
require_relative './progressbar'

class Checker
	def process_word (line)
	end

	def get_results (total_lines_processed)
	end
end

# these have to go after the class above
require_relative './us_area_codes.rb'
require_relative './us_zip_codes.rb'
require_relative './colour_checker.rb'
require_relative './windows_complexity_checker.rb'
require_relative './date_checker.rb'
require_relative './hashcat_mask_generator.rb'

if RUBY_VERSION =~ /1\.8/
	puts "Sorry, Pipal only works correctly on Ruby 1.9.x."
	puts
	exit
end

trap("SIGINT") { throw :ctrl_c }

time = Benchmark.measure do

char_stats = {
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

char_sets_ordering = {
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

words = {}
total_lines = 0

one_to_six_chars = 0
one_to_eight_chars = 0
over_eight_chars = 0
#only_lower_alpha_chars = 0
#only_upper_alpha_chars = 0
#only_numeric_chars = 0

first_cap_last_num = 0
first_cap_last_num_re = /^[A-Z].*[0-9]$/
first_cap_last_symbol = 0
first_cap_last_symbol_re = /^[A-Z].*[\p{Punct}]$/

# this is the count of words with 1, 2 and 3 numbers on the end
singles_on_end_re = /[^0-9]+([0-9]{1})$/
singles_on_end = 0
doubles_on_end_re = /[^0-9]+([0-9]{2})$/
doubles_on_end = 0
triples_on_end_re =/[^0-9]+([0-9]{3})$/ 
triples_on_end = 0

# this is the actual last number on the end, single digit
last_on_end = []
0.upto(4) do |no_of_digits|
	last_on_end[no_of_digits] = {}
end

# last two and three numbers on the end
last_two_on_end = {}
last_three_on_end = {}

class String
	def is_numeric?
		Integer self rescue false
	end
end

def is_numeric val
	return val.to_s =~ /^[0-9]+$/
end

opts = GetoptLong.new(
	[ '--help', '-h', "-?", GetoptLong::NO_ARGUMENT ],
	[ '--top', "-t" , GetoptLong::REQUIRED_ARGUMENT ],
	[ '--output', "-o" , GetoptLong::REQUIRED_ARGUMENT ],
	[ '--external', "-e" , GetoptLong::REQUIRED_ARGUMENT ],
	[ '--gkey', GetoptLong::REQUIRED_ARGUMENT ],
	[ "-v" , GetoptLong::NO_ARGUMENT ]
)

# Display the usage
def usage
	puts"pipal 2.0 Robin Wood (robin@digininja.org) (www.digininja.org)

Usage: pipal [OPTION] ... FILENAME
	--help, -h: show help
	--top, -t X: show the top X results (default 10)
	--output, -o <filename>: output to file
	--external, -e <filename>: external file to compare words against
	--gkey <Google Maps API key>: to allow zip code lookups (optional)

	FILENAME: The file to count

"
	exit
end

cap_at = 10
output_file = STDOUT
external_list = {}
# Need to find a way to handle this properly
google_maps_api_key = ""

begin
	opts.each do |opt, arg|
		case opt
			when '--help'
				usage
			when "--top"
				if arg.is_numeric?
					cap_at = arg.to_i
					if cap_at <= 0
						puts"pipal 2.0 Robin Wood (robin@digininja.org) (www.digininja.org)

Please enter a positive number of lines

"
						exit 1
					end
				else
					puts"pipal 2.0 Robin Wood (robin@digininja.org) (www.digininja.org)

Invalid number of lines

"
					exit 1
				end
			when "--gkey"
				google_maps_api_key = arg
			when "--external"
				if File.exist?(arg)
					begin
						File.open(arg, 'r').each_line do |word|
							external_list[word.force_encoding("ASCII-8BIT").strip] = 0 unless word.force_encoding("ASCII-8BIT").strip == ''
						end
					rescue Errno::EACCES => e
						puts"pipal 2.0 Robin Wood (robin@digininja.org) (www.digininja.org)

Unable to open external file

"
						exit 1
					end
				else
					puts"pipal 2.0 Robin Wood (robin@digininja.org) (www.digininja.org)

Unable to find external file

"
					exit 1
				end
			when "--output"
				begin
					output_file = File.new(arg, "w")
				rescue Errno::EACCES => e
					puts"pipal 2.0 Robin Wood (robin@digininja.org) (www.digininja.org)

Unable to open output file

"
					exit 1
				end
		end
	end
rescue GetoptLong::InvalidOption => e
	puts
	usage
	exit
rescue => e
	puts "Something went wrong, please report it to robin@digininja.org along with these messages:"
	puts
	puts e.message
	puts
	puts e.class.to_s
	puts
	puts "Backtrace:"
	puts e.backtrace
	puts
	usage
	exit 1
end

if ARGV.length != 1
	puts"pipal 2.0 Robin Wood (robin@digininja.org) (www.digininja.org)

Please specify the file to count

"
	exit 1
end

filename = ARGV.shift

if !File.exist? filename
	puts"pipal 2.0 Robin Wood (robin@digininja.org) (www.digininja.org)

Can't find the password file

"
	exit 2
end

lengths = []
max_length = 0
base_words = {}

puts "Generating stats, hit CTRL-C to finish early and dump stats on words already processed."
puts "Please wait..."

if %x{wc -l '#{filename}'}.match(/\s*([0-9]+).*/)
	file_line_count = $1.to_i
else
	filesize = File.stat(filename).size
	file_line_count = (filesize / 8).to_i
	puts "Can't find wc to calculate the number of lines so guessing as " + file_line_count.to_s + " based on file size"
end

pbar = ProgressBar.new("Processing", file_line_count)

modules = []
modules << Date_Checker.new
modules << Colour_Checker.new
modules << Windows_Complexity_Checker.new
modules << US_Area_Code_Checker.new
modules << US_Zip_Code_Checker.new
modules << Hashcat_Mask_Generator.new

catch :ctrl_c do
	begin
		File.open(filename, "r").each_line do |line|
			begin
				line.strip!
				if line == ""
					pbar.inc
					next
				end
				# Doing this so that I can support a wider range of characters, a UK pound sign
				# breaks the app without it
				line.force_encoding("ASCII-8BIT")
				lower_line = line.downcase

				if !words.has_key?(line)
					words[line] = 0
				end
				words[line] += 1

				modules.each do |mod|
					mod.process_word(line)
				end

				# strip any non-alpha from the start or end, I was going to strip all non-alpha
				# but then found a list with Unc0rn as a very common base. Stripping all non-alpha
				# would leave with Uncrn which doesn't really make any sense as without the 133t speak
				# it is out of context.
				#
				# If you want all non-alpha stripped use the following line instead
				#
				# word_just_alpha = lower_line.gsub(/[^a-z]*/, "")
				#
				word_just_alpha = lower_line.gsub(/^[^a-z]*/, "").gsub(/[^a-z]*$/, '')
				if word_just_alpha.length > 3
					if !base_words.has_key?(word_just_alpha)
						base_words[word_just_alpha] = 0
					end
					base_words[word_just_alpha] += 1
				end

				if lengths[line.length].nil?
					lengths[line.length] = 0
				end
				lengths[line.length] += 1

				if line.length < 9
					one_to_eight_chars += 1
				end

				if line.length < 7
					one_to_six_chars += 1
				end

				if line.length > 8
					over_eight_chars += 1
				end

				if line =~ first_cap_last_symbol_re
					first_cap_last_symbol += 1
				end

				if line =~ first_cap_last_num_re
					first_cap_last_num += 1
				end

				external_list.each_pair do |domain, count|
					if /#{Regexp.quote(domain)}/i.match line
						external_list[domain] += 1
					end
				end

				if singles_on_end_re.match line
					singles_on_end += 1
				end
				
				# Can't merge these two as the first is strict, 2 digits on the end, the second 
				# just wants the last two digits regardless
				if doubles_on_end_re.match line
					doubles_on_end += 1
				end

				if triples_on_end_re.match line
				#if line =~ /[^0-9]+([0-9]{3})$/ 
					triples_on_end += 1
				end
				
				1.upto(5) do |no_of_digits|
					if /([0-9]{#{no_of_digits}})$/.match line
						last_numbers = $1
						if !last_on_end[no_of_digits - 1].has_key?(last_numbers)
							last_on_end[no_of_digits - 1][last_numbers] = 0
						end
						last_on_end[no_of_digits - 1][last_numbers] += 1
					end

				end
				
				char_stats.each_pair do |name, data|
					begin
						if line =~ data['regex']
							char_stats[name]['count'] += 1
							break
						end
					rescue Encoding::CompatibilityError
						puts "Encoding problem found with password: " + line
					end
				end

				char_sets_ordering.each_pair do |name, data|
					begin
						if lower_line =~ data['regex']
							char_sets_ordering[name]['count'] += 1
							break
						end
					rescue Encoding::CompatibilityError
						puts "Encoding problem found with password: " + line
					end
				end

				pbar.inc

				total_lines += 1
			rescue ArgumentError => e
				puts "Encoding problem processing word: " + line
				pbar.inc
			rescue => e
				puts "Something went wrong, please report it to robin@digininja.org along with these messages:"
				puts
				puts e.message
				puts
				puts e.class.to_s
				puts
				puts "Backtrace:"
				puts e.backtrace
				puts
				exit 1
			end
		end
	rescue Errno::EACCES => e
		puts"pipal 2.0 Robin Wood (robin@digininja.org) (www.digininja.org)

Unable to open the password file

"
		exit 1
	rescue => e
		puts "Something went wrong, please report it to robin@digininja.org along with these messages:"
		puts
		puts e.message
		puts
		puts e.class.to_s
		puts
		puts "Backtrace:"
		puts e.backtrace
		puts
		usage
		exit 1
	end
end

pbar.halt

# This is a screen puts to clear after the status bars in case the data is being written to the screen, do not add outfile to it
puts
puts

output_file.puts "Total entries = #{total_lines.to_s}"
uniq_words = words.to_a.uniq
output_file.puts "Total unique entries = #{uniq_words.length.to_s}"
uniq_words = Array.new(words.to_a.uniq)

output_file.puts
output_file.puts "Top #{cap_at.to_s} passwords"
# The default is to sort lowest to highest, the -1 just inverts that
words.sort{|a,b| (a[1]<=>b[1]) * -1}[0, cap_at].each { |elem|
	percentage = (elem[1].to_f / total_lines) * 100
	output_file.puts "#{elem[0]} = #{elem[1].to_s} (#{percentage.round(2).to_s}%)"
}

output_file.puts
output_file.puts "Top #{cap_at.to_s} base words"
base_words.sort{|a,b| (a[1]<=>b[1]) * -1}[0, cap_at].each { |elem|
	percentage = (elem[1].to_f / total_lines) * 100
	output_file.puts "#{elem[0]} = #{elem[1].to_s} (#{percentage.round(2).to_s}%)"
}

output_file.puts
output_file.puts "Password length (length ordered)"

length_ordered = []
0.upto(lengths.count) do |len|
	if lengths[len].nil?
		lengths[len] = 0
	end
	percentage = ((lengths[len].to_f / total_lines) * 100)
	output_file.puts "#{len.to_s} = #{lengths[len].to_s} (#{percentage.round(2).to_s}%)" if lengths[len] > 0
	
	pair = [len, lengths[len], percentage]
	length_ordered << pair
end

length_ordered.sort! do |x,y|
	y[1] <=> x[1]
end

output_file.puts
output_file.puts "Password length (count ordered)"
length_ordered.each do |pair|
	output_file.puts "#{pair[0].to_s} = #{pair[1].to_s} (#{pair[2].round(2).to_s}%)" if pair[1] > 0
end

output_file.puts

horiz = HorizBar.new(lengths)
horiz.output_file = output_file
horiz.draw

output_file.puts "One to six characters = #{one_to_six_chars.to_s} (#{((one_to_six_chars.to_f/total_lines) * 100).round(2).to_s}%)"
output_file.puts "One to eight characters = #{one_to_eight_chars.to_s} (#{((one_to_eight_chars.to_f/total_lines) * 100).round(2).to_s}'%)"
output_file.puts "More than eight characters = #{over_eight_chars.to_s} (#{((over_eight_chars.to_f/total_lines) * 100).round(2).to_s}%)"

output_file.puts

output_file.puts "Only lowercase alpha = " + char_stats['loweralpha']['count'].to_s + ' (' + ((char_stats['loweralpha']['count'].to_f/total_lines) * 100).round(2).to_s + '%)'
output_file.puts "Only uppercase alpha = " + char_stats['upperalpha']['count'].to_s + ' (' + ((char_stats['upperalpha']['count'].to_f/total_lines) * 100).round(2).to_s + '%)'
output_file.puts "Only alpha = " + (char_stats['upperalpha']['count'] + char_stats['loweralpha']['count']).to_s + ' (' + (((char_stats['upperalpha']['count'] + char_stats['loweralpha']['count']).to_f/total_lines) * 100).round(2).to_s + '%)'

output_file.puts "Only numeric = " + char_stats['numeric']['count'].to_s + ' (' + ((char_stats['numeric']['count'].to_f/total_lines) * 100).round(2).to_s + '%)'

output_file.puts
output_file.puts "First capital last symbol = " + first_cap_last_symbol.to_s + ' (' + ((first_cap_last_symbol.to_f/total_lines) * 100).round(2).to_s + '%)'
output_file.puts "First capital last number = " + first_cap_last_num.to_s + ' (' + ((first_cap_last_num.to_f/total_lines) * 100).round(2).to_s + '%)'

if external_list.length > 0
	count_ordered = []
	external_list.each_pair do |domain, count|
		count_ordered << [domain, count] unless count == 0
	end
	external_list = count_ordered.sort do |x,y|
		(x[1] <=> y[1]) * -1
	end

	output_file.puts
	output_file.puts "External list (Top " + cap_at.to_s + ")"
	disp = false
	external_list[0, cap_at].each do |data|
		disp = true
		output_file.puts data[0] + " = " + data[1].to_s + ' (' + ((data[1].to_f/total_lines) * 100).round(2).to_s + '%)'
	end
	unless disp
		output_file.puts "None found"
	end
end

modules.each do |mod|
	output_file.puts mod.get_results(total_lines)
	output_file.puts
end

output_file.puts "Single digit on the end = " + singles_on_end.to_s + ' (' + ((singles_on_end.to_f/total_lines) * 100).round(2).to_s + '%)'
output_file.puts "Two digits on the end = " + doubles_on_end.to_s + ' (' + ((doubles_on_end.to_f/total_lines) * 100).round(2).to_s + '%)'
output_file.puts "Three digits on the end = " + triples_on_end.to_s + ' (' + ((triples_on_end.to_f/total_lines) * 100).round(2).to_s + '%)'

output_file.puts
output_file.puts "Last number"
disp = false

graph_numbers = {0=>0, 1=>0, 2=>0, 3=>0, 4=>0, 5=>0, 6=>0, 7=>0, 8=>0, 9=>0}

c = last_on_end[0].to_a.sort do |x,y|
	(x[0] <=> y[0])
end

c.each do |number, count|
	unless count == 0
		disp = true
		output_file.puts number.to_s + " = " + count.to_s + ' (' + ((count.to_f/total_lines) * 100).round(2).to_s + '%)' unless count == 0
	end
	graph_numbers[number.to_i] = count
end
unless disp
	output_file.puts "None found"
end

output_file.puts
horiz = HorizBar.new(graph_numbers.values)
horiz.output_file = output_file
horiz.draw

digit_number = 0
last_on_end.each do |a|
	c = a.to_a.sort do |x,y|
		(x[1] <=> y[1]) * -1
	end

	digit_number += 1
	if c.count > 0
		if (digit_number == 1)
			output_file.puts "Last digit"
		else
			output_file.puts "Last " + digit_number.to_s + " digits (Top " + cap_at.to_s + ")"
		end

		c[0, cap_at].each do |d|
			output_file.puts d[0] + " = " + d[1].to_s + ' (' + ((d[1].to_f/total_lines) * 100).round(2).to_s + '%)'
		end
		
		output_file.puts
	end
end

count_ordered = []
char_stats.each_pair do |name, data|
	count_ordered << [name, data] unless data['count'] == 0
end
char_stats = count_ordered.sort do |x,y|
	(x[1]['count'] <=> y[1]['count']) * -1
end

output_file.puts "Character sets"
char_stats.each do |name, data|
	output_file.puts name + ": " + data['count'].to_s + " (" + ((data['count'].to_f/total_lines) * 100).round(2).to_s + "%)"
end

count_ordered = []
char_sets_ordering.each_pair do |name, data|
	count_ordered << [name, data] unless data['count'] == 0
end
char_sets_ordering = count_ordered.sort do |x,y|
	(x[1]['count'] <=> y[1]['count']) * -1
end

output_file.puts
output_file.puts "Character set ordering"
char_sets_ordering.each do |name, data|
	output_file.puts name + ": " + data['count'].to_s + " (" + ((data['count'].to_f/total_lines) * 100).round(2).to_s + "%)"
end

output_file.puts

end
puts time if false
