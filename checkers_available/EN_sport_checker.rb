# Written by Micah Hoffman (@webbreacher)

require_relative "../list_checker.rb"

register_checker("Sport_Checker")

class Sport_Checker < List_Checker
	def initialize
		super
		@description = "List of English sport terms"
		@list = {
		            "archery" => 0,
		            "baseball" => 0,
		            "basketball" => 0,
		            "ball" => 0,
		            "bowl" => 0,
		            "fight" => 0,
		            "football" => 0,
		            "hockey" => 0,
		            "marathon" => 0,
		            "martial" => 0,
		            "mma" => 0,
		            "olympic" => 0,
		            "race" => 0,
		            "rugby" => 0,
		            "run" => 0,
		            "soccer" => 0,
		            "softball" => 0,
		            "swim" => 0
		        }
	end

	def get_results()
		return super("Sport")
	end
end
