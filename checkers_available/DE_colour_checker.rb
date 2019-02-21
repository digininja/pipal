# encoding: utf-8
# Written by Jan Rude (@whoot)

require_relative "../list_checker.rb"

register_checker("DE_Colour_Checker")

class DE_Colour_Checker < List_Checker
	def initialize
		super
		@description = "List of common German colours"
		@list = {
					"schwarz" => 0, 
					"blau" => 0,
					"braun" => 0,
					"grau" => 0,
					"grün" => 0,
					"indigo" => 0,
					"orange" => 0,
					"rosa" => 0,
					"lila" => 0,
					"rot" => 0,
					"violett" => 0,
					"weiß" => 0,
					"gelb" => 0
				}
	end

	def get_results()
		return super("German Colours")
	end
end
