# Written by Micah Hoffman (@webbreacher)

require_relative "../list_checker.rb"

register_checker("Vehicle_Checker")

class Vehicle_Checker < List_Checker
	def initialize
		super
		@description = "List of common vehicle manufacturers and models"
		@list = {
		            "audi" => 0,
		            "bmw" => 0,
		            "cadillac" => 0,
		            "car" => 0,
		            "chevy" => 0,
		            "dodge" => 0,
		            "ferrari" => 0,
		            "ford" => 0,
		            "honda" => 0,
		            "mercedes" => 0,
		            "porshe" => 0,
		            "toyota" => 0,
		            "truck" => 0,
		            "volkswagon" => 0
		        }
	end

	def get_results()
		return super("Vehicle")
	end
end
