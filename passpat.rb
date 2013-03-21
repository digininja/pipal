#!/usr/bin/env ruby
#coding: utf-8

#
# Author:: Robin Wood (robin@digininja.org)
# Copyright:: Copyright (c) Robin Wood 2013
# Licence:: Creative Commons Attribution-Share Alike 2.0
#

require 'getoptlong'

def usage
	puts"passpat 1.0 Robin Wood (robin@digininja.org) (www.digininja.org)

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

"
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
					puts"passpat 1.0 Robin Wood (robin@digininja.org) (www.digininja.org)
						
Add directory listing of the layouts directory
					"

					exit 0
			when "--layout"
				# Yes, directory traversal is here but don't care
				if File.exist?("./layouts/" + arg + ".rb")
					require "./layouts/" + arg + ".rb"
				else
					puts"passpat 1.0 Robin Wood (robin@digininja.org) (www.digininja.org)

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

if $layout.nil?
	puts"passpat 1.0 Robin Wood (robin@digininja.org) (www.digininja.org)

No layout file specified

"
	exit 1
end

keyboard = $layout

if verbose
	puts "Using layout file: " + $layout_description
	puts
end

filename = ARGV.shift

if !File.exist? filename
	puts"passpat 1.0 Robin Wood (robin@digininja.org) (www.digininja.org)

Can't find the password file

"
	exit 2
end

total_lines = 0
total_score = 0

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
							puts "checking #{c} and last char is #{last_char}" if verbose

							keyboard[c].each do | diff, chars|
								puts "comparing #{chars} at diff #{diff}" if verbose
								if chars.count(last_char) > 0
									# The character is next to the last one
									score += diff
									puts "found" if verbose
									found = true
								end
							end
							if !found
								score += MAX_SCORE
							end
						else
							puts "character not found in mapping: " + c if verbose
							score += MAX_SCORE
						end
					end
					last_char = c
				end

				puts "Password: #{original_password}"
				puts "Total score = #{score.to_s}"
				puts "Number of moves = #{pass.length.to_s}"
				# stops divide by zero problems
				if pass.length == 0
					puts "Pattern score = 0 out of " + MAX_SCORE.to_s
				else
					puts "Pattern score = #{(score.to_f / (pass.length)).to_s} out of " + MAX_SCORE.to_s
					total_score += (score.to_f / (pass.length))
				end
				puts

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
				usage
				exit 1
			end
		end
		puts "Total passwords processed: #{total_lines.to_s}"
		if total_lines > 0
			puts "Overall pattern score #{(total_score.to_f / total_lines).to_s} out of #{MAX_SCORE}"
		end
	rescue Errno::EACCES => e
		puts"passpat 1.0 Robin Wood (robin@digininja.org) (www.digininja.org)

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

