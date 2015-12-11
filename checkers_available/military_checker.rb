# Written by Micah Hoffman (@webbreacher)

require_relative "../list_checker.rb"

register_checker("Military_Checker")

class Military_Checker < List_Checker
	def initialize
		super
		@description = "List of military terms"
		@list = {
		           	"air force" => 0,
		            "airforce" => 0,
		            "army" => 0,
		            "attack" => 0,
		            "boat" => 0,
		            "bomb" => 0,
		            "bullet" => 0,
		            "camo" => 0,
		            "captain" => 0,
		            "classified" => 0,
		            "dead" => 0,
		            "death" => 0,
		            "defend" => 0,
		            "explode" => 0,
		            "fight" => 0,
		            "gun" => 0,
		            "kill" => 0,
		            "intel" => 0,
		            "jet" => 0,
		            "marine" => 0,
		            "medal" => 0,
		            "missile" => 0,
		            "navy" => 0,
		            "pilot" => 0,
		            "protect" => 0,
		            "rocket" => 0,
		            "seargeant" => 0,
		            "ship" => 0,
		            "shoot" => 0,
		            "sub" => 0,
		            "tank" => 0,
		            "warrior" => 0
		        }
	end

	def get_results()
		return super("Military")
	end
end
