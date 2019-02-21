# Written by Jan Rude (@whoot)

require_relative "../list_checker.rb"

register_checker("DE_Religion_Checker")

class DE_Religion_Checker < List_Checker
	def initialize
		super
		@description = "List of German religious terms"
		@list = {
		            "Allah" => 0,
		            "Bibel" => 0,
		            "gesegnet" => 0,
		            "Buddha" => 0,
		            "wohltätig" => 0,
		            "Christus" => 0,
		            "Kleriker" => 0,
		            "Teufel" => 0,
		            "böse" => 0,
		            "Glaube" => 0,
		            "Gott" => 0,
		            "Gnade" => 0,
		            "Halleluja" => 0,
		            "Himmel" => 0,
		            "Hoffnung" => 0,
		            "heilig" => 0,
		            "Hindu" => 0,
		            "Islam" => 0,
		            "Jesus" => 0,
		            "Jude" => 0,
		            "Königreich" => 0,
		            "Koran" => 0,
		            "Herr" => 0,
		            "Pastor" => 0,
		            "Mulla" => 0,
		            "Paradies" => 0,
		            "Papst" => 0,
		            "beten" => 0,
		            "lobpreisen" => 0,
		            "Priester" => 0,
		            "Prophet" => 0,
		            "Sprichwort" => 0,
		            "Psalm" => 0,
		            "Rabbiner" => 0,
		            "erlösen" => 0,
		            "Erlösung" => 0,
		            "Religion" => 0,
		            "bereuen" => 0,
		            "geheiligt" => 0,
		            "geweiht" => 0,
		            "Heiliger" => 0,
		            "Satan" => 0,
		            "Erlöser" => 0,
		            "Retter" => 0,
		            "Sünde" => 0,
		            "Seele" => 0,
		            "Geist" => 0,
		            "Thora" => 0
		        }
	end

	def get_results()
		return super("German Religion")
	end
end
