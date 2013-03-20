#!/usr/bin/env ruby
#coding: utf-8

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
	puts "passpat.rb <password>"
	puts
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
