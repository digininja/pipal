# Written by Micah Hoffman (@webbreacher)

require_relative "../list_checker.rb"

register_checker("Family_Checker")

class Family_Checker < List_Checker
	def initialize
		super
		@description = "List of English family terms"
		@list = {
		            "aunt" => 0,
		            "babies" => 0,
		            "baby" => 0,
		            "brother" => 0,
		            "child" => 0,
		            "dad" => 0,
		            "daughter" => 0,
		            "family" => 0,
		            "father" => 0,
		            "grandfather" => 0,
		            "grandma" => 0,
		            "grandpa" => 0,
		            "grandm" => 0,
		            "grandp" => 0,
		            "husband" => 0,
		            "inlaw" => 0,
		            "kid" => 0,
		            "lover" => 0,
		            "mama" => 0,
		            "marriage" => 0,
		            "married" => 0,
		            "mom" => 0,
		            "mother" => 0,
		            "nana" => 0,
		            "nephew" => 0,
		            "niece" => 0,
		            "papa" => 0,
		            "parent" => 0,
		            "partner" => 0,
		            "pop" => 0,
		            "pregnant" => 0,
		            "sister" => 0,
		            "son" => 0,
		            "spouse" => 0,
		            "twin" => 0,
		            "uncle" => 0,
		            "wife" => 0,
		            "wive" => 0
		        }
	end

	def get_results()
		return super("Family")
	end
end
