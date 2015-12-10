# Written by Micah Hoffman (@webbreacher)

require_relative "../list_checker.rb"

register_checker("Explicit_Checker")

class Explicit_Checker < List_Checker
	def initialize
		super
		@description = "List of explicit terms"
		@list = {
		            "anal" => 0,
		            "asshole" => 0,
		            "balls" => 0,
		            "bitch" => 0,
		            "bites" => 0,
		            "blowjob" => 0,
		            "boob" => 0,
		            "bugger" => 0,
		            "butt" => 0,
		            "clit" => 0,
		            "cock" => 0,
		            "coon" => 0,
		            "crap" => 0,
		            "cunt" => 0,
		            "damn" => 0,
		            "dick" => 0,
		            "dumb" => 0,
		            "dyke" => 0,
		            "fag" => 0,
		            "fuck" => 0,
		            "gay" => 0,
		            "hell" => 0,
		            "homo" => 0,
		            "jackass" => 0,
		            "nigger" => 0,
		            "penis" => 0,
		            "prick" => 0,
		            "pussy" => 0,
		            "queer" => 0,
		            "rape" => 0,
		            "retard" => 0,
		            "shit" => 0,
		            "slut" => 0,
		            "stupid" => 0,
		            "suck" => 0,
		            "tramp" => 0,
		            "twat" => 0,
		            "whore" => 0
		         }
	end

	def get_results()
		return super("Explicit")
	end
end
