# Written by Micah Hoffman (@webbreacher)

require_relative "../list_checker.rb"

register_checker("Violence_Checker")

class Violence_Checker < List_Checker
	def initialize
		super
		@description = "List of English violent terms"
		@list = {
		           	"attack" => 0,
		            "beat" => 0,
		            "bomb" => 0,
		            "dead" => 0,
		            "death" => 0,
		            "explode" => 0,
		            "fight" => 0,
		            "gut" => 0,
		            "hate" => 0,
		            "kill" => 0,
		            "rage" => 0,
		            "revolt" => 0,
		            "riot" => 0,
		            "slice" => 0,
		            "shoot" => 0,
		            "stab" => 0
		        }
	end

	def get_results()
		return super("Violence")
	end
end
