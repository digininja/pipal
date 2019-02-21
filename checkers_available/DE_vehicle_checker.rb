# Written by Jan Rude (@whoot)

require_relative "../list_checker.rb"

register_checker("DE_Vehicle_Checker")

class DE_Vehicle_Checker < List_Checker
	def initialize
		super
		@description = "List of common vehicle manufacturers and models"
		@list = {
		            "Audi" => 0,
		            "BMW" => 0,
		            "Cadillac" => 0,
		            "Auto" => 0,
		            "Dodge" => 0,
		            "Opel" => 0,
		            "Skoda" => 0,
		            "Renault" => 0,
		            "Dacia" => 0,
		            "Ferrari" => 0,
		            "Ford" => 0,
		            "Fiat" => 0,
		            "Mini" => 0,
		            "Mazda" => 0,
		            "Honda" => 0,
		            "Smart" => 0,
		            "Seat" => 0,
		            "Hyundai" => 0,
		            "Jeep" => 0,
		            "Motorrad" => 0,
		            "Mercedes" => 0,
		            "Porsche" => 0,
		            "Toyota" => 0,
		            "LKW" => 0,
		            "VW" => 0,
		            "Volkswagen" => 0,
		            "Golf" => 0,
		            "Polo" => 0,
		            "Volvo" => 0,
		            "Tesla" => 0,
		            "Kia" => 0,
		            "Nissan" => 0,
		            "Jaguar" => 0
		        }
	end

	def get_results()
		return super("German Vehicle")
	end
end
