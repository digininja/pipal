# encoding: utf-8
require_relative "../list_checker.rb"
register_checker("FR_Colour_Checker")

class FR_Colour_Checker < Checker
	def initialize
		super

		@list = {"noir" => 0, "bleu" => 0, "marron" => 0, "gris" => 0, "vert" => 0,
		"orange" => 0, "rose" => 0, "rouge" => 0, "blanc" => 0, "jaune" => 0, 
		"violet" => 0, "indigo" => 0, "ocre" => 0, "cyan" => 0, "ocre" => 0}
		@description = "List of common French colours"
	end

	def get_results()
		return super("Couleurs")
	end
end
