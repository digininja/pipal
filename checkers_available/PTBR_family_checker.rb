# Written by Micah Hoffman (@webbreacher)
# PT-BR version by Daniel Marques (@0xc0da)

require_relative "../list_checker.rb"

register_checker("PTBR_Family_Checker")

class PTBR_Family_Checker < List_Checker
	def initialize
		super
		@description = "List of Brazilian Portuguese family terms"
		@list = {
		            "titia" => 0,
								"tia" => 0,
		            "bebes" => 0,
		            "bebe" => 0,
		            "irmao" => 0,
		            "crianca" => 0,
		            "papai" => 0,
		            "filha" => 0,
		            "familia" => 0,
		            "pai" => 0,
								"paizinho" => 0,
		            "avo" => 0,
		            "vovo" => 0,
		            "vovis" => 0,
								"vozinha" => 0,
								"vozinho" => 0,
		            "marido" => 0,
		            "parente" => 0,
		            "filho" => 0,
		            "amante" => 0,
		            "mamae" => 0,
								"mae" => 0,
								"maezinha" => 0,
		            "casamento" => 0,
		            "casado" => 0,
		            "sobrinho" => 0,
		            "sobrinha" => 0,
		            "dindo" => 0,
								"dinda" => 0,
		            "gravida" => 0,
		            "irma" => 0,
		            "esposa" => 0,
								"esposo" => 0,
		            "tio" => 0,
								"titio" => 0,
		            "sogra" => 0,
								"sogro" => 0,
		            "padrinho" => 0
		        }
	end

	def get_results()
		return super("Brazilian Portuguese Family")
	end
end
