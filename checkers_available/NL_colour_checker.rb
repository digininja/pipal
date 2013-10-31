require_relative "../list_checker.rb"

register_checker("NL_Colour_Checker")

class Colour_Checker < List_Checker
	def initialize
		super
		@description = "List of common dutch colours"
		@list = {"zwart" => 0, "blauw" => 0, "bruin" => 0, "grijs" => 0, "groen" => 0, "oranje" => 0, "roze" => 0, "paars" => 0, "rood" => 0, "wit" => 0, "geel" => 0, 'violet' => 0, 'indigo' => 0}
	end

	def get_results()
		return super("Colours")
	end
end
