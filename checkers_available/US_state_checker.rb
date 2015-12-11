# Written by Micah Hoffman (@webbreacher)

require_relative "../list_checker.rb"

register_checker("US_State_Checker")

class US_State_Checker < List_Checker
	def initialize
		super
		@description = "List of United States states"
		@list = {
		            "alabama" => 0,
		            "alaska" => 0,
		            "arizona" => 0,
		            "arkansas" => 0,
		            "california" => 0,
		            "colorado" => 0,
		            "connecticut" => 0,
		            "delaware" => 0,
		            "florida" => 0,
		            "georgia" => 0,
		            "hawaii" => 0,
		            "idaho" => 0,
		            "illinois" => 0,
		            "indiana" => 0,
		            "iowa" => 0,
		            "kansas" => 0,
		            "kentucky" => 0,
		            "louisiana" => 0,
		            "maine" => 0,
		            "maryland" => 0,
		            "massachusetts" => 0,
		            "michigan" => 0,
		            "minnesota" => 0,
		            "mississippi" => 0,
		            "missouri" => 0,
		            "montana" => 0,
		            "nebraska" => 0,
		            "nevada" => 0,
		            "newhampshire" => 0,
		            "new hampshire" => 0,
		            "newjersey" => 0,
		            "new jersey" => 0,
		            "newmexico" => 0,
		            "new mexico" => 0,
		            "newyork" => 0,
		            "new york" => 0,
		            "northcarolina" => 0,
		            "north carolina" => 0,
		            "northdakota" => 0,
		            "north dakota" => 0,
		            "ohio" => 0,
		            "oklahoma" => 0,
		            "oregon" => 0,
		            "pennsylvania" => 0,
		            "rhodeisland" => 0,
		            "rhode island" => 0,
		            "southcarolina" => 0,
		            "south carolina" => 0,
		            "southdakota" => 0,
		            "south dakota" => 0,
		            "tennessee" => 0,
		            "texas" => 0,
		            "utah" => 0,
		            "vermont" => 0,
		            "virginia" => 0,
		            "washington" => 0,
		            "westvirginia" => 0,
		            "west virginia" => 0,
		            "wisconsin" => 0,
		            "wyoming" => 0
		         }
	end

	def get_results()
		return super("US_State")
	end
end
