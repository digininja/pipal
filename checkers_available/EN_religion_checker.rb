# Written by Micah Hoffman (@webbreacher)

require_relative "../list_checker.rb"

register_checker("Religion_Checker")

class Religion_Checker < List_Checker
	def initialize
		super
		@description = "List of religious terms"
		@list = {
		            "allah" => 0,
		            "bible" => 0,
		            "bless" => 0,
		            "buddha" => 0,
		            "christ" => 0,
		            "cleric" => 0,
		            "devil" => 0,
		            "evil" => 0,
		            "faith" => 0,
		            "god" => 0,
		            "grace" => 0,
		            "hallelujah" => 0,
		            "heaven" => 0,
		            "holy" => 0,
		            "hindu" => 0,
		            "islam" => 0,
		            "jesus" => 0,
		            "jew" => 0,
		            "kingdom" => 0,
		            "koran" => 0,
		            "lord" => 0,
		            "minister" => 0,
		            "mulla" => 0,
		            "paradise" => 0,
		            "pope" => 0,
		            "pray" => 0,
		            "praise" => 0,
		            "priest" => 0,
		            "prophet" => 0,
		            "proverb" => 0,
		            "psalm" => 0,
		            "rabbi" => 0,
		            "redeem" => 0,
		            "redemption" => 0,
		            "religion" => 0,
		            "repent" => 0,
		            "sacred" => 0,
		            "saint" => 0,
		            "satan" => 0,
		            "savior" => 0,
		            "saviour" => 0,
		            "sin" => 0,
		            "spirit" => 0,
		            "torah" => 0
		        }
	end

	def get_results()
		return super("Religion")
	end
end
