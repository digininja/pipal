# Written by Jan Rude (@whoot)

require_relative "../list_checker.rb"

register_checker("DE_Road_Checker")

class DE_Road_Checker < List_Checker
	def initialize
		super
		@description = "List of German road terms"
		@list = {
		            "Gasse" => 0,
		            "Allee" => 0,
		            "Brücke" => 0,
		            "Hof" => 0,
		            "Einfahrt" => 0,
		            "Autobahn" => 0,
		            "Fernstraße" => 0,
		            "Fahrbahn" => 0,
		            "Parkplatz" => 0,
		            "Straße" => 0,
		            "Strecke" => 0,
		            "Querstraße" => 0,
		            "Fußgängerweg" => 0,
		            "Zebrastreifen" => 0,
		            "Tunnel" => 0,
		            "Gehweg" => 0,
		        }
	end

	def get_results()
		return super("German Road")
	end
end
