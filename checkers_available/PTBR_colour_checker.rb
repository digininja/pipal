# PT-BR version by Daniel Marques (@0xc0da)

require_relative "../list_checker.rb"

register_checker("Colour_Checker")

class Colour_Checker < List_Checker
	def initialize
		super
		@description = "List of common Brazilian Portuguese colours"
		@list = {
					"preto" => 0,
					"azul" => 0,
					"marrom" => 0,
					"cinza" => 0,
					"verde" => 0,
					"prata" => 0,
					"laranja" => 0,
					"rosa" => 0,
					"roxo" => 0,
					"vermelho" => 0,
					"violeta" => 0,
					"branco" => 0,
					"amarelo" => 0
				}
	end

	def get_results()
		return super("Brazilian Portuguese Colours")
	end
end
