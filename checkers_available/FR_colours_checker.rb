# encoding: utf-8
require_relative "../wordlist_checker.rb"
register_checker("FR_Colour_Checker")

class FR_Colour_Checker < Wordlist_Checker
	def initialize
		super("./dico/FR_colours.txt")
	end

	def get_results()
		return super("French colours")
	end
end
