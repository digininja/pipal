# Written by Jan Rude (@whoot)

require_relative "../list_checker.rb"

register_checker("DE_Family_Checker")

class DE_Family_Checker < List_Checker
	def initialize
		super
		@description = "List of German family terms"
		@list = {
		            "Tante" => 0,
		            "Babys" => 0,
		            "Baby" => 0,
		            "Bruder" => 0,
		            "Kind" => 0,
		            "Vater" => 0,
		            "Tochter" => 0,
		            "Familie" => 0,
		            "Papa" => 0,
		            "Großvater" => 0,
		            "Großmutter" => 0,
		            "Opa" => 0,
		            "Oma" => 0,
		            "Ehemann" => 0,
		            "Schwiegereltern" => 0,
		            "Liebhaber" => 0,
		            "Mama" => 0,
		            "Heirat" => 0,
		            "verheiratet" => 0,
		            "Mami" => 0,
		            "Mutter" => 0,
		            "Neffe" => 0,
		            "Nichte" => 0,
		            "Papi" => 0,
		            "Eltern" => 0,
		            "Partner" => 0,
		            "Paps" => 0,
		            "schwanger" => 0,
		            "Schwester" => 0,
		            "Sohn" => 0,
		            "Ehepartner" => 0,
		            "Zwilling" => 0,
		            "Onkel" => 0,
		            "Frau" => 0,
		            "Ehefrau" => 0
		        }
	end

	def get_results()
		return super("German Family")
	end
end
