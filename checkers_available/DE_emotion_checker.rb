# Written by Jan Rude (@whoot)

require_relative "../list_checker.rb"

register_checker("DE_Emotion_Checker")

class DE_Emotion_Checker < List_Checker
	def initialize
		super
		@description = "List of German emotional terms"
		@list = {
		            "Wut" => 0,
		            "fantastisch" => 0,
		            "schlecht" => 0,
		            "schön" => 0,
		            "gelangweilt" => 0,
		            "verwirrt" => 0,
		            "verrückt" => 0,
		            "Neid" => 0,
		            "Angst" => 0,
		            "Gut" => 0,
		            "großartig" => 0,
		            "glücklich" => 0,
		            "Hass" => 0,
		            "Hoffnung" => 0,
		            "verletzt" => 0,
		            "wahnsinnig" => 0,
		            "Freude" => 0,
		            "nett" => 0,
		            "Liebe" => 0,
		            "Schmerz" => 0,
		            "Mitleid" => 0,
		            "traurig" => 0,
		            "Scham" => 0,
		            "müde" => 0,
		            "Vertrauen" => 0
		        }
	end

	def get_results()
		return super("German Emotion")
	end
end
