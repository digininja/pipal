# PT-BR version by Daniel Marques (@0xc0da)

require_relative "../list_checker.rb"

register_checker("PTBR_Season_Checker")

class PTBR_Season_Checker < List_Checker
	def initialize
		super
		@description = "List of common Brazilian Portuguese seasons"
		@list = {"verao" => 0, "outono" => 0, "inverno" => 0, "primavera" => 0}
	end

	def get_results()
		return super("Brazilian Portuguese Seasons")
	end
end
