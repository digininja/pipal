# Written by Matthieu Keller (@matthieukeller)

require_relative "../list_checker.rb"

register_checker("FR_Family_Checker")

class FR_Family_Checker < List_Checker
	def initialize
		super
		@description = "List of French family terms"
		@list = {
		            "amant" => 0,
		            "bébé" => 0,
		            "bébés" => 0,
		            "enceinte" => 0,
		            "enfant" => 0,
		            "famille" => 0,
		            "femme" => 0,
		            "fille" => 0,
		            "fils" => 0,
		            "frère" => 0,
		            "grand-mère" => 0,
		            "grand-père" => 0,
		            "jumeau" => 0,
		            "maitresse" => 0,
		            "maman" => 0,
		            "mamie" => 0,
		            "mari" => 0,
		            "marriage" => 0,
		            "marrié" => 0,
		            "maîtresse" => 0,
		            "mère" => 0,
		            "neveu" => 0,
		            "nièce" => 0,
		            "oncle" => 0,
		            "papa" => 0,
		            "papi" => 0,
		            "parent" => 0,
		            "partenaire" => 0,
		            "père" => 0,
		            "sœur" => 0,
		            "tante" => 0,
		            "épou" => 0,
		            "épouse" => 0
		        }
	end

	def get_results()
		return super("French Family")
	end
end
