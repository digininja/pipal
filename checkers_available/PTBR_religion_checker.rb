# Written by Micah Hoffman (@webbreacher)
# PT-BR version by Daniel Marques (@0xc0da)

require_relative "../list_checker.rb"

register_checker("PTBR_Religion_Checker")

class PTBR_Religion_Checker < List_Checker
	def initialize
		super
		@description = "List of Brazilian Portuguese religious terms"
		@list = {
		            "biblia" => 0,
		            "bencao" => 0,
		            "caridade" => 0,
		            "cristo" => 0,
								"cristao" => 0,
		            "pastor" => 0,
		            "diabo" => 0,
		            "demonio" => 0,
		            "fe" => 0,
		            "deus" => 0,
		            "graca" => 0,
		            "aleluia" => 0,
		            "ceu" => 0,
		            "jesus" => 0,
		            "santo" => 0,
		            "reino" => 0,
		            "senhor" => 0,
		            "papa" => 0,
		            "oracao" => 0,
		            "padre" => 0,
		            "profeta" => 0,
		            "proverbio" => 0,
		            "salmo" => 0,
		            "redentor" => 0,
		            "redencao" => 0,
		            "religiao" => 0,
		            "sagrado" => 0,
		            "satan" => 0,
								"satanas" => 0,
		            "salvador" => 0,
		            "pecado" => 0,
		            "espirito" => 0,
								"kardec" => 0,
								"kardecismo" => 0,
								"kardecista" => 0,
								"candomble" => 0,
								"umbanda" => 0,
								"pilintra" => 0,
								"pelintra" => 0,
								"padilha" => 0,
								"gira" => 0,
								"exu" => 0,
								"ogum" => 0,
								"oxossi" => 0,
								"logunede" => 0,
								"xango" => 0,
								"ayra" => 0,
								"obaluaiye" => 0,
								"oxumare" => 0,
								"ossaim" => 0,
								"oya" => 0,
								"iansa" => 0,
								"oxum" => 0,
								"iemanja" => 0,
								"nana" => 0,
								"yewa" => 0,
								"oba" => 0,
								"axabo" => 0,
								"ibeji" => 0,
								"iroco" => 0,
								"egungun" => 0,
								"omolu" => 0,
								"onile" => 0,
								"oxala" => 0,
								"orixanla" => 0,
								"obatala" => 0,
								"ifa" => 0,
								"orunmila" => 0,
								"odudua" => 0,
								"oranian" => 0,
								"baiani" => 0,
								"olokun" => 0,
								"olossa" => 0,
								"oxalufan" => 0,
								"oxaguian" => 0,
								"oke" => 0,
								"otin" => 0,
								"erinle" => 0,
								"ori" => 0,
								"dende" => 0
		        }
	end

	def get_results()
		return super("Brazilian Portuguese Religion")
	end
end
