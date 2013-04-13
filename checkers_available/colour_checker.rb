require_relative "../list_checker.rb"

register_checker("Colour_Checker")

class Colour_Checker < List_Checker
	@@list = {"black" => 0, "blue" => 0, "brown" => 0, "gray" => 0, "green" => 0, "orange" => 0, "pink" => 0, "purple" => 0, "red" => 0, "white" => 0, "yellow" => 0, 'violet' => 0, 'indigo' => 0}

	attr_accessor :description

	def initialize
		self.description = "List of common English colours"
	end

	def get_results()
		return super("Colours")
	end
end
