# Written by Matthieu Keller (@matthieukeller)

require_relative "../list_checker.rb"

register_checker("FR_Emotion_Checker")

class FR_Emotion_Checker < List_Checker
	def initialize
		super
		@description = "List of French emotional terms"
		@list = {
				"affection" => 0,
				"agitation" => 0,
				"amour" => 0,
				"amusement" => 0,
				"angoisse" => 0,
				"anxiété" => 0,
				"appréhension" => 0,
				"attirance" => 0,
				"chagrin" => 0,
				"colère" => 0,
				"compassion" => 0,
				"culpabilité" => 0,
				"déception" => 0,
				"défaitisme" => 0,
				"dégoût" => 0,
				"déprime" => 0,
				"désespoir" => 0,
				"désir" => 0,
				"désire" => 0,
				"détresse" => 0,
				"effroi" => 0,
				"empathie" => 0,
				"ennui" => 0,
				"enthousiasme" => 0,
				"envie" => 0,
				"épouvante" => 0,
				"espoir" => 0,
				"euphorie" => 0,
				"exaltation" => 0,
				"exaspération" => 0,
				"excitation" => 0,
				"extase" => 0,
				"fierté" => 0,
				"frustration" => 0,
				"fureur" => 0,
				"gaieté" => 0,
				"haine" => 0,
				"honte" => 0,
				"horreur" => 0,
				"hostilité" => 0,
				"humiliation" => 0,
				"hystérie" => 0,
				"inquiétude" => 0,
				"irritation" => 0,
				"jalousie" => 0,
				"joie" => 0,
				"jubilation" => 0,
				"malaise" => 0,
				"malheur" => 0,
				"mélancolie" => 0,
				"négligence" => 0,
				"nervosité" => 0,
				"nostalgie" => 0,
				"optimisme" => 0,
				"panique" => 0,
				"passion" => 0,
				"peine" => 0,
				"peur" => 0,
				"pitié" => 0,
				"plaisir" => 0,
				"rage" => 0,
				"rancune" => 0,
				"regret" => 0,
				"remords" => 0,
				"ressentiment" => 0,
				"révulsion" => 0,
				"satisfaction" => 0,
				"solitude" => 0,
				"souffrance" => 0,
				"surprise" => 0,
				"sympathie" => 0,
				"tendresse" => 0,
				"tension" => 0,
				"terreur" => 0,
				"tourment" => 0,
				"tristesse" => 0
				}
	end

	def get_results()
		return super("French Emotion")
	end
end
