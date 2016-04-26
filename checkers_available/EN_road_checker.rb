require_relative "../list_checker.rb"

register_checker("Road_Checker")

class Road_Checker < List_Checker
	def initialize
		super
		@description = "List of English road terms"
		@list = {
		            "alley" => 0,
		            "avenue" => 0,
		            "boulevard" => 0,
		            "bridge" => 0,
		            "court" => 0,
		            "drive" => 0,
		            "highway" => 0,
		            "interstate" => 0,
		            "lane" => 0,
		            "parkway" => 0,
		            "place" => 0,
		            "road" => 0,
		            "route" => 0,
		            "square" => 0,
		            "street" => 0,
		            "terrace" => 0,
		            "tunnel" => 0,
		            "walk" => 0,
		            "way" => 0
		        }
	end

	def get_results()
		return super("Road")
	end
end
