require_relative "../list_checker.rb"

register_checker("Season_Checker")

class Season_Checker < List_Checker
	def initialize
		super
		@description = "List of common English seasons"
		@list = {"summer" => 0, "fall" => 0, "winter" => 0, "spring" => 0, "autumn" => 0}
	end

	def get_results()
		return super("Seasons")
	end
end
