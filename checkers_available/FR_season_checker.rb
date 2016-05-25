require_relative "../list_checker.rb"

register_checker("FR_Season_Checker")

class FR_Season_Checker < List_Checker
	def initialize
		super
		@description = "List of common French seasons"
		@list = {"été" => 0, "automne" => 0, "hiver" => 0, "printemps" => 0, "ete" => 0}
	end

	def get_results()
		return super("French Seasons")
	end
end
