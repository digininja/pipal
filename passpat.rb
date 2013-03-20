#!/usr/bin/env ruby
#coding: utf-8

#
# Author:: Robin Wood (robin@digininja.org)
# Copyright:: Copyright (c) Robin Wood 2013
# Licence:: Creative Commons Attribution-Share Alike 2.0
#

# the UK pound sign breaks some editors so just specifying it
# as a char code rather than the symbol
gbp = 163.chr

keyboard_uk = {
				"!" => { 0 => "1", 1 => "2\"q"},
				"1" => { 0 => "!", 1 => "2\"q"},
				"q" => { 1 => "1!2\"wa"},
				"a" => { 1 => "qwsxz\\"},
				"z" => { 1 => "asx\\"},
				"|" => { 0 => "\\", 1 => "az"},
				"\\" => { 0 => "|", 1 => "az"},
				"2" => { 0 => '"', 1 => "1!qw3"+ gbp},
				'"' => { 0 => '2', 1 => "1!qw3"+ gbp},
				"w" => { 1 => "2\"3edsaq"+ gbp},
				"s" => { 1 => "qwedcxza"},
				"x" => { 1 => "zasdc"},
				"3" => { 0 => "" + gbp, 1 => "2wer4\""},
				gbp => { 0 => "3", 1 => "2wer4\""},
				"e" => { 1 => "w34rfds"+ gbp},
				"d" => { 1 => "werfvcxs"},
				"c" => { 1 => "xsdfv"},
				"4" => { 0 => "$", 1 => "3er5"+ gbp},
				"$" => { 0 => "4", 1 => "3er5"+ gbp},
				"r" => { 1 => "4$5%tgfde"},
				"f" => { 1 => "ertgvcd"},
				"v" => { 1 => "cfgb"},
				"5" => { 0 => "%", 1 => "4$rt6^"},
				"%" => { 0 => "%", 5 => "4$rt6^"},
				"t" => { 1 => "5%6^ygr"},
				"g" => { 1 => "vbhfty"},
				"b" => { 1 => "vghn"},
			}

keyboard_number_pad = {
						"0" => { 1 => "12"},
						"1" => { 1 => "4520"},
						"2" => { 1 => "014563"},
						"3" => { 1 => "256"},
						"4" => { 1 => "78521"},
						"5" => { 1 => "12346789"},
						"6" => { 1 => "98523"},
						"7" => { 1 => "458"},
						"8" => { 1 => "74569"},
						"9" => { 1 => "856"},
					}

MAX_SCORE = 2

verbose = false
keyboard = keyboard_number_pad
keyboard = keyboard_uk

def usage
	puts"passpat 1.0 Robin Wood (robin@digininja.org) (www.digininja.org)

Usage: passpat.rb <password>

NOTE - FOR TESTING ONLY THE LEFT HALF OF THE UK KEYBOARD HAS BEEN MAPPED

The results are scored from 0 to #{MAX_SCORE.to_s}. A score of 0 means that a the
password didn't move from a single key, a score of 1 means that each key entered
was adjacent to the previous. #{MAX_SCORE.to_s} means that no keys were next to each other.

Based on this, the closer to 1 the score is, the more likely the password is
to be a keyboard pattern.

Note though, this will not pick up a pattern such as \"qpalzm\" as the system isn't
that smart (yet).

"
end

if ARGV.length != 1
	usage
	exit
end
pass = ARGV.shift

# Don't care about case
pass = pass.downcase

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
			score += 2
		end
	end
	last_char = c
end

puts "Total score = #{score.to_s}"
puts "Number of moves = #{pass.length.to_s}"
puts "Pattern score = #{(score.to_f / (pass.length)).to_s} out of " + MAX_SCORE.to_s
