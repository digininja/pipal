# Written by Jan Rude (@whoot)

require_relative "../list_checker.rb"

register_checker("DE_Sport_Checker")

class DE_Sport_Checker < List_Checker
	def initialize
		super
		@description = "List of German sport terms"
		@list = {
		            "Bogenschießen" => 0,
		            "Baseball" => 0,
		            "Basketball" => 0,
		            "Ball" => 0,
		            "Kugel" => 0,
		            "Wettkampf" => 0,
		            "Fußball" => 0,
		            "Mockey" => 0,
		            "Marathon" => 0,
		            "Kampfsport" => 0,
		            "olympisch" => 0,
		            "Wettrennen" => 0,
		            "Wettlauf" => 0,		            
		            "Rugby" => 0,
		            "Softball" => 0,
		            "Schwimmen" => 0
		        }
	end

	def get_results()
		return super("German Sport")
	end
end
