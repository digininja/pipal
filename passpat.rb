#!/usr/bin/env ruby
# encoding: utf-8

#
# Author:: Robin Wood (robin@digi.ninja)
# Copyright:: Copyright (c) Robin Wood 2013
# Licence:: Creative Commons Attribution-Share Alike 2.0
#

require 'getoptlong'

def usage
	puts"passpat 1.0 Robin Wood (robin@digi.ninja) (http://digi.ninja)

Usage: passpat.rb [OPTIONS] ... PASSWORD_FILE
    --layout x, -l x: use the layout file specified. No default is set so this
                       must be specified
    --list-layouts: show the available layout files
    --help, -h: show help
    --verbose, -v: verbose messages

    PASSWORD_FILE: the list of passwords to check

The results are scored from 0 to upwards. A score of 0 means that a the
password didn't move from a single key, a score of 1 means that each key entered
was adjacent to the previous. The higher the score above 1, the lower the 
grouping of the keys.

Based on this, the closer to 1 the score is, the more likely the password is
to be a keyboard pattern.

Note though, this will not pick up a pattern such as \"qpalzm\" as the system isn't
that smart (yet).

This project is sponsored by the BruCON 5x5 scheme.

"
end

def list_layouts
	puts"passpat 1.0 Robin Wood (robin@digi.ninja) (http://digi.ninja)"
	puts
	puts "Available layouts:"
	puts

	# This gives the directory that passpat is running from
	script_directory = File.dirname(__FILE__)
						
	layouts = Dir[script_directory + '/layouts/*'].reject do |fn| File.directory?(fn) end
	layouts.each do |layout|
		layout_name = layout.match(/#{script_directory + '/layouts/'}(.*)\.rb$/)
		if !layout_name.nil?
			puts layout_name[1]
		end
	end
	puts
end

opts = GetoptLong.new(
	[ '--help', '-h', "-?", GetoptLong::NO_ARGUMENT ],
	[ '--layout', "-l" , GetoptLong::REQUIRED_ARGUMENT ],
	[ '--list-layouts', GetoptLong::NO_ARGUMENT ],
	[ "--verbose", "-v" , GetoptLong::NO_ARGUMENT ]
)

verbose = false

begin
	opts.each do |opt, arg|
		case opt
			when '--verbose'
				verbose = true
			when '--help'
				usage
				exit 0
			when "--list-layouts"
				list_layouts
				exit 0
			when "--layout"
				# This gives the directory that passpat is running from
				script_directory = File.dirname(__FILE__)
				
				puts script_directory + "/layouts/" + arg + ".rb"
				# Yes, directory traversal is here but don't care
				if File.exist?(script_directory + "/layouts/" + arg + ".rb")
					require_relative "layouts/" + arg + ".rb"
				else
					puts"passpat 1.0 Robin Wood (robin@digi.ninja) (http://digi.ninja)

Layout file not found

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
	puts "Something went wrong, please report it to robin@digi.ninja along with these messages:"
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

if $layout.nil?
	puts"passpat 1.0 Robin Wood (robin@digi.ninja) (http://digi.ninja)

No layout file specified

"
	exit 1
end

keyboard = $layout

if verbose
	puts "Using layout file: " + $layout_description
	puts
end

if ARGV.count < 1
	puts"passpat 1.0 Robin Wood (robin@digi.ninja) (http://digi.ninja)

No password file specified

"
	exit 1
end

filename = ARGV.shift

if filename.nil? or !File.exist? filename
	puts"passpat 1.0 Robin Wood (robin@digi.ninja) (http://digi.ninja)

Can't find the password file

"
	exit 1
end

total_lines = 0
total_score = 0
total_zeros = 0
total_ones = 0

catch :ctrl_c do
	begin
		File.open(filename, "r").each_line do |line|
			begin
				# because the password processed in the loop is lower case
				# and has the first character stripped off it
				original_password = line.strip

				if original_password == ""
					next
				end

				# Don't care about case
				pass = original_password.downcase

				if verbose
					puts "Checking password: #{pass}"
					puts
				end

				score = 0
				# take the first character and store it
				last_char = pass[0]

				# remove the first character
				pass = pass[1 .. -1]

				pass.each_char do |c|
					if c == last_char
						# just to indicate what is actually happening
						# the characters are the same so the score
						# stays the same
						score += 0
					else
						if keyboard.has_key?(c)
							found = false
							puts "Moving from #{last_char} to #{c}" if verbose

							keyboard[c].each do | diff, chars|
								puts "\tCharacters #{diff} keys away: #{chars}" if verbose
								if chars.count(last_char) > 0
									# The character is next to the last one
									score += diff
									puts "\tCharacter found at score #{diff}" if verbose
									found = true
									break
								end
							end
							if !found
								puts "\tNext key not found so using default score #{MAX_SCORE}" if verbose
								score += MAX_SCORE
							end
						else
							puts "Character not found in mapping: #{c} so scoring default #{MAX_SCORE}" if verbose
							score += MAX_SCORE
						end
					end
					last_char = c
					puts "Current total score #{score}" if verbose
				end

				puts "Password: #{original_password}"
				puts "Total score = #{score.to_s}"
				puts "Number of moves = #{pass.length.to_s}"
				# stops divide by zero problems
				if pass.length == 0
					puts "Pattern score = 0 out of " + MAX_SCORE.to_s
					total_zeros += 1
				else
					avg_score = (score.to_f / pass.length)
					puts "Pattern score = #{avg_score.to_s} out of " + MAX_SCORE.to_s
					total_score += avg_score
					if avg_score == 0
						total_zeros += 1
					elsif avg_score == 1
						total_ones += 1
					end
				end
				puts

				total_lines += 1
			rescue ArgumentError => e
				puts "Encoding problem processing word: " + line
			rescue => e
				puts "Something went wrong, please report it to robin@digi.ninja along with these messages:"
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
		puts "Total passwords processed: #{total_lines.to_s}"
		if total_lines > 0
			puts "Overall pattern score #{(total_score.to_f / total_lines).to_s} out of #{MAX_SCORE}"
		end
		puts "Total length zeros found: #{total_zeros.to_s}"
		puts "Total length ones found: #{total_ones.to_s}"
	rescue Errno::EACCES => e
		puts"passpat 1.0 Robin Wood (robin@digi.ninja) (http://digi.ninja)

Unable to open the password file

"
		exit 1
	rescue => e
		puts "Something went wrong, please report it to robin@digi.ninja along with these messages:"
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
