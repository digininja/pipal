# Written by Daniel C. Marques (@0xc0da)
# Full wordlist of soccer teams available here:
# https://github.com/BRDumps/wordlists/blob/master/brazilian-soccer-teams.txt

require_relative "../list_checker.rb"

register_checker("BR_Soccer_Teams_Checker")

class BR_Soccer_Teams_Checker < List_Checker
	def initialize
		super
		@description = "List of Brazilian Soccer Teams"
		@list = {
								"america" => 0,
		            "atletico" => 0,
		            "avai" => 0,
		            "bahia" => 0,
		            "botafogo" => 0,
		            "ceara" => 0,
		            "coelho" => 0,
		            "coringao" => 0,
		            "corinthians" => 0,
		            "coritiba" => 0,
		            "cruzeiro" => 0,
		            "figueira" => 0,
		            "figueirense" => 0,
		            "fla" => 0,
		            "flamengo" => 0,
		            "flu" => 0,
		            "fluminense" => 0,
		            "flusao" => 0,
		            "fogao" => 0,
		            "fogo" => 0,
		            "fortaleza" => 0,
		            "galo" => 0,
		            "goias" => 0,
		            "gremio" => 0,
		            "guarani" => 0,
		            "inter" => 0,
		            "internacional" => 0,
		            "juve" => 0,
		            "juventude" => 0,
		            "lusa" => 0,
		            "macaca" => 0,
		            "mengao" => 0,
		            "mengo" => 0,
		            "nautico" => 0,
		            "nense" => 0,
		            "palmeiras" => 0,
		            "parana" => 0,
		            "paysandu" => 0,
		            "peixe" => 0,
		            "ponte preta" => 0,
		            "porco" => 0,
		            "portuguesa" => 0,
		            "raposa" => 0,
		            "remo" => 0,
		            "santacruz" => 0,
		            "santos" => 0,
		            "sao paulo" => 0,
		            "sport" => 0,
		            "timao" => 0,
		            "tricolor" => 0,
		            "vascao" => 0,
		            "vasco" => 0,
		            "verdao" => 0,
		            "vilanova" => 0,
		            "vitoria" => 0
		        }
	end

	def get_results()
		return super("Brazilian Soccer Teams")
	end
end
