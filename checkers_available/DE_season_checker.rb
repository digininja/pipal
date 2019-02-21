# Written by Jan Rude (@whoot)

require_relative "../list_checker.rb"

register_checker("DE_Season_Checker")

class DE_Season_Checker < List_Checker
	def initialize
		super
		@description = "List of common German seasons"
		@list = {"Sommer" => 0, "Frühling" => 0, "Herbst" => 0, "Winter" => 0}
	end

	def get_results()
		return super("German Seasons\n=======")
	end
end
