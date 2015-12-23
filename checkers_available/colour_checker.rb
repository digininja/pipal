require_relative "../list_checker.rb"

register_checker("Colour_Checker")

class Colour_Checker < List_Checker
	def initialize
		super
		@description = "List of common English colours"
		@list = {"black" => 0, "blue" => 0, "brown" => 0, "gray" => 0, "green" => 0, "orange" => 0, "pink" => 0, "purple" => 0, "red" => 0, "white" => 0, "yellow" => 0, 'violet' => 0, 'indigo' => 0}
	end

	def get_results()
		return super("Colours\n=======")
	end
end
