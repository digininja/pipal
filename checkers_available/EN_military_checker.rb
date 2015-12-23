# Written by Micah Hoffman (@webbreacher)

require_relative "../list_checker.rb"

register_checker("Military_Checker")

class Military_Checker < List_Checker
	def initialize
		super
		@description = "List of English military terms"
		@list = {
		           	"air force" => 0,
		            "airborn" => 0,
		            "airforce" => 0,
		            "army" => 0,
		            "boat" => 0,
		            "bomb" => 0,
		            "bullet" => 0,
		            "camo" => 0,
		            "captain" => 0,
		            "classified" => 0,
		            "defend" => 0,
		            "gun" => 0,
		            "intel" => 0,
		            "jet" => 0,
		            "marine" => 0,
		            "medal" => 0,
		            "missile" => 0,
		            "navy" => 0,
		            "pilot" => 0,
		            "protect" => 0,
		            "ranger" => 0,
		            "rocket" => 0,
		            "seal" => 0,
		            "seargeant" => 0,
		            "ship" => 0,
		            "sniper" => 0,
		            "specialforce" => 0,
		            "sub" => 0,
		            "tank" => 0,
		            "warrior" => 0
		        }
	end

	def get_results()
		return super("Military")
	end
end
