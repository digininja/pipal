require_relative "../list_checker.rb"

register_checker("NL_Season_Checker")

class NL_Season_Checker < List_Checker
	def initialize
		super
		@description = "List of common Dutch seasons"
		@list = {"zomer" => 0, "herfst" => 0, "winter" => 0, "lente" => 0}
	end

	def get_results()
		return super("Dutch Seasons")
	end
end
