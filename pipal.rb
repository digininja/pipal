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
require'net/http'
require'uri'
require'json'
require "pathname"

VERSION = "3.0 alpha"

# Find out what our base path is
base_path = File.expand_path(File.dirname(__FILE__))
require File.join(base_path, 'base_checker.rb')
require File.join(base_path, 'progressbar.rb')
require File.join(base_path, 'pipal_getoptlong.rb')

if RUBY_VERSION =~ /1\.8/
	puts "Sorry, Pipal only works correctly on Ruby >= 1.9.x."
	puts
	exit
end

class PipalException < Exception
end

@checkers = []

def register_checker (class_name)
	@checkers << class_name
end

trap("SIGINT") { throw :ctrl_c }

# uncomment this and its pair towards the end to benchmark the app
#time = Benchmark.measure do

class String
	def is_numeric?
		Integer self rescue false
	end
end

def puts_msg_with_header (msg)
	puts"pipal #{VERSION} Robin Wood (robin@digininja.org) (www.digininja.org)\n"
	puts msg
	puts "\n"
end

# Display the usage
def usage
	puts"pipal #{VERSION} Robin Wood (robin@digininja.org) (www.digininja.org)

Usage: pipal [OPTION] ... FILENAME
	--help, -h: show help
	--top, -t X: show the top X results (default 10)
	--output, -o <filename>: output to file
	--external, -e <filename>: external file to compare words against
	--gkey <Google Maps API key>: to allow zip code lookups (optional)
	--list-checkers: Show the available checkers and which are enabled
	--verbose, -v: Verbose

	FILENAME: The file to count

"
	exit
end

def list_checkers
	all_checkers = {}

	# Find out what our base path is
	base_path = File.expand_path(File.dirname(__FILE__))

	Dir.glob(base_path + '/checkers_enabled/*rb').select do |fn|
		if !File.directory? fn
			# Ruby doesn't seem to like doing a require
			# on a symlink so this finds the ultimate target
			# of the link (i.e. will travel multiple links)
			# and require that instead
			require Pathname.new(fn).realpath
		end
	end

	@checkers.each do |class_name|
		mod = Object::const_get(class_name).new
		all_checkers[class_name] = {'description' => mod.description, 'enabled' => true}
	end

	@checkers = []
	Dir.glob(base_path + '/checkers_available/*rb').select do |fn|
		if !File.directory? fn
			# Ruby doesn't seem to like doing a require
			# on a symlink so this finds the ultimate target
			# of the link (i.e. will travel multiple links)
			# and require that instead
			require Pathname.new(fn).realpath
		end
	end

	@checkers.each do |class_name|
		mod = Object::const_get(class_name).new
		all_checkers[class_name] = {'description' => mod.description, 'enabled' => false}
	end

	puts "pipal #{VERSION} Robin Wood (robin@digininja.org) (www.digininja.org)"
	puts
	puts "You have the following Checkers on your system"
	puts "=============================================="

	all_checkers.sort.each do |check|
		puts "#{check[0]} - #{check[1]['description']}" + (check[1]['enabled']?" - Enabled":"")
	end
	
	puts

	exit
end

# Defaults
verbose = false
cap_at = 10
output_file = STDOUT
custom_word_splitter = nil

if File.exists?(File.join(base_path, "custom_splitter.rb"))
	require Pathname.new(File.join(base_path, "custom_splitter.rb")).realpath
	custom_word_splitter = Custom_word_splitter
end

Dir.glob(base_path + '/checkers_enabled/*rb').select do |f|
	require_list = []
	if !File.directory? f
		require_list << f
	end
	require_list.sort.each do |fn|
		# Ruby doesn't seem to like doing a require
		# on a symlink so this finds the ultimate target
		# of the link (i.e. will travel multiple links)
		# and require that instead
		require Pathname.new(fn).realpath
	end
end

modules = []

opts = PipalGetoptLong.new(
	[ '--help', '-h', GetoptLong::NO_ARGUMENT ],
	[ '--top', "-t" , GetoptLong::REQUIRED_ARGUMENT ],
	[ '--output', "-o" , GetoptLong::REQUIRED_ARGUMENT ],
	[ '--external', "-e" , GetoptLong::REQUIRED_ARGUMENT ],
	[ '--gkey', GetoptLong::REQUIRED_ARGUMENT ],
	[ "--verbose", "-v" , GetoptLong::NO_ARGUMENT ],
	[ "--list-checkers" , GetoptLong::NO_ARGUMENT ],
)

@checkers.each do |class_name|
	mod = Object::const_get(class_name).new
	modules << mod
	
	# If the module has any parameters then they 
	# will be in the cli_params attribute as an array
	# so go through it and add them all to the main options list
	if !mod.cli_params.nil?
		mod.cli_params.each do |param|
			opts.add_option(param)
		end
	end
end

begin
	# Having to store them as once you've parsed through opts once you can't do it
	# again as far as I can tell, all the values disappear.
	stored_opts = {}

	opts.each do |opt, arg|
		stored_opts[opt] = arg
		case opt
			when '--help'
				usage
			when "--list-checkers"
				list_checkers
				exit
			when "--top"
				if arg.is_numeric?
					cap_at = arg.to_i
					if cap_at <= 0
						puts_msg_with_header("Please enter a positive number of lines")
						exit 1
					end
				else
					puts_msg_with_header("Invalid number of lines")
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
						puts_msg_with_header("Unable to open external file")
						exit 1
					end
				else
					puts_msg_with_header("Unable to find external file")
					exit 1
				end
			when "--output"
				begin
					output_file = File.new(arg, "w")
				rescue Errno::EACCES => e
					puts_msg_with_header("Unable to open output file")
					exit 1
				end
			when "--verbose"
				verbose = true
		end
	end

	# allow each of the modules to pull out the CLI params they require
	# and pass through any global values
	modules.each do |mod|
		mod.verbose = verbose
		mod.cap_at = cap_at
		mod.parse_params stored_opts
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
	puts_msg_with_header("Please specify the file to analyse")
	exit 1
end

filename = ARGV.shift

if !File.exist? filename
	puts_msg_with_header("Can't find the password file")
	exit 2
end

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

catch :ctrl_c do
	begin
		File.open(filename, "r").each_line do |line|
			begin
				line.strip!
				if line == ""
					pbar.inc
					next
				end
				# single threaded
				modules.each do |mod|
					if !custom_word_splitter.nil?
						word, extras = Custom_word_splitter::split(line)
					else
						word = line
						extras = {}
					end

					mod.process_word(word, extras)
				end

		# Multi-threaded. With just 5 modules this makes the script about 25% slower
		#		threads = []
		#		modules.each do |mod|
		#			threads << Thread.new(line) do |my_line|
		#				mod.process_word(my_line)
		#			end
		#		end
		#		threads.each do | a_thread | a_thread.join end


				pbar.inc
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
		puts_msg_with_header("Unable to open the password file")
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

modules.each do |mod|
	output_file.puts mod.get_results
	output_file.puts
end

output_file.puts

# Companion to the commented out benchmark at the top
#end
#puts time
