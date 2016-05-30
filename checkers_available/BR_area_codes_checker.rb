# BR version by Daniel Marques (@0xc0da)

register_checker("BR_Area_Code_Checker")

BR_area_codes = {}

BR_area_codes[11] = ["SP","Sao Paulo/Guarulhos/Sao Bernardo do Campo/Santo Andre/Osasco/Jundiai"]
BR_area_codes[12] = ["SP","Sao Jose dos Campos/Taubate/Jacarei/Guaratingueta"]
BR_area_codes[13] = ["SP","Santos/Sao Vicente/Praia Grande/Cubatao/Itanhaem/Peruibe"]
BR_area_codes[14] = ["SP","Bauru/Jau/Marilia/Lencois Paulista/Botucatu/Ourinhos/Avare"]
BR_area_codes[15] = ["SP","Sorocaba/Itapetininga/Itapeva"]
BR_area_codes[16] = ["SP","Ribeirao Preto/Sao Carlos/Araraquara"]
BR_area_codes[17] = ["SP","Sao Jose do Rio Preto/Barretos/Fernandopolis"]
BR_area_codes[18] = ["SP","Presidente Prudente/Aracatuba/Birigui/Assis"]
BR_area_codes[19] = ["SP","Campinas/Piracicaba/Limeira/Americana/Sumare"]
BR_area_codes[21] = ["RJ","Rio de Janeiro/Niteroi/Sao Goncalo/Duque de Caxias/Nova Iguacu"]
BR_area_codes[22] = ["RJ","Campos dos Goytacazes/Macae/Cabo Frio/Nova Friburgo"]
BR_area_codes[24] = ["RJ","Volta Redonda/Barra Mansa/Petropolis"]
BR_area_codes[27] = ["ES","Vitoria/Serra/Vila Velha/Linhares"]
BR_area_codes[28] = ["ES","Cachoeiro de Itapemirim"]
BR_area_codes[31] = ["MG","Belo Horizonte/Contagem/Betim"]
BR_area_codes[32] = ["MG","Juiz de Fora/Barbacena"]
BR_area_codes[33] = ["MG","Governador Valadares/Teofilo Otoni/Caratinga/Manhuacu"]
BR_area_codes[34] = ["MG","Uberlandia/Uberaba/Araguari/Araxa"]
BR_area_codes[35] = ["MG","Pocos de Caldas/Pouso Alegre/Varginha"]
BR_area_codes[37] = ["MG","Divinopolis/Itauna/Formiga/Capitolio"]
BR_area_codes[38] = ["MG","Montes Claros/Serro/Januaria"]
BR_area_codes[41] = ["PR","Curitiba/Sao Jose dos Pinhais/Paranagua"]
BR_area_codes[42] = ["PR","Ponta Grossa/Castro/Uniao da Vitoria"]
BR_area_codes[43] = ["PR","Londrina/Arapongas/Assai/Jacarezinho/Jandaia do Sul"]
BR_area_codes[44] = ["PR","Maringa/Campo Mourao/Astorga"]
BR_area_codes[45] = ["PR","Cascavel/Toledo/Medianeira"]
BR_area_codes[46] = ["PR","Francisco Beltrao/Pato Branco/Palmas"]
BR_area_codes[47] = ["SC","Joinville/Blumenau/Balneario Camboriu"]
BR_area_codes[48] = ["SC","Florianopolis/Sao Jose/Criciuma"]
BR_area_codes[49] = ["SC","Chapeco/Lages/Concordia"]
BR_area_codes[51] = ["RS","Porto Alegre/Canoas/Esteio/Torres"]
BR_area_codes[53] = ["RS","Pelotas/Rio Grande/Bage/Acegua/Chui"]
BR_area_codes[54] = ["RS","Caxias do Sul/Vacaria/Veranopolis"]
BR_area_codes[55] = ["RS","Santa Maria/Uruguaiana/Santana do Livramento"]
BR_area_codes[61] = ["DF/GO","Brasilia/Luziania/Valparaiso de Goias/Formosa"]
BR_area_codes[62] = ["GO","Goiania/Anapolis/Luziania/Goias/Pirenopolis"]
BR_area_codes[63] = ["TO","Palmas/Araguaina/Gurupi"]
BR_area_codes[64] = ["GO","Rio Verde/Jatai/Caldas Novas/Catalao"]
BR_area_codes[65] = ["MT","Cuiaba/Varzea Grande/Caceres"]
BR_area_codes[66] = ["MT","Rondonopolis/Sinop/Barra do Garcas"]
BR_area_codes[67] = ["MS","Campo Grande/Dourados/Corumba"]
BR_area_codes[68] = ["AC","Rio Branco/Cruzeiro do Sul"]
BR_area_codes[69] = ["RO","Porto Velho/Ji-Parana/Ariquemes"]
BR_area_codes[71] = ["BA","Salvador/Camacari/Lauro de Freitas"]
BR_area_codes[73] = ["BA","Itabuna/Ilheus/Porto Seguro/Jequie"]
BR_area_codes[74] = ["BA","Juazeiro/Xique-Xique"]
BR_area_codes[75] = ["BA","Feira de Santana/Alagoinhas/Lencois"]
BR_area_codes[77] = ["BA","Vitoria da Conquista/Barreiras/Correntina"]
BR_area_codes[79] = ["SE","Aracaju/Lagarto/Itabaiana"]
BR_area_codes[81] = ["PE","Recife/Jaboatao dos Guararapes/Goiana/Gravata/Paulista"]
BR_area_codes[82] = ["AL","Maceio/Arapiraca/Palmeira dos indios/Penedo"]
BR_area_codes[83] = ["PB","Joao Pessoa/Campina Grande/Patos/Sousa/Cajazeiras"]
BR_area_codes[84] = ["RN","Natal/Mossoro/Parnamirim/Caico"]
BR_area_codes[85] = ["CE","Fortaleza/Caucaia/Russas/Maracanau"]
BR_area_codes[86] = ["PI","Teresina/Parnaiba/Piripiri/Campo Maior/Barras"]
BR_area_codes[87] = ["PB","Petrolina/Salgueiro/Arcoverde"]
BR_area_codes[88] = ["CE","Juazeiro do Norte/Crato/Sobral/Itapipoca/Iguatu/Quixada"]
BR_area_codes[89] = ["PI","Picos/Floriano/Oeiras/Sao Raimundo Nonato/Corrente"]
BR_area_codes[91] = ["PA","Belem/Ananindeua/Castanhal/Abaetetuba/Braganca"]
BR_area_codes[92] = ["AM","Manaus/Iranduba/Parintins/Itacoatiara/Maues/Borba"]
BR_area_codes[93] = ["PA","Santarem/Altamira/Oriximina/Itaituba/Jacareacanga"]
BR_area_codes[94] = ["PA","Maraba/Tucurui/Parauapebas/Redencao/Santana do Araguaia"]
BR_area_codes[95] = ["RR","Boa Vista/Rorainopolis/Caracarai/Alto Alegre/Mucajai"]
BR_area_codes[96] = ["AP","Macapa/Santana/Laranjal do Jari/Oiapoque/Calcoene"]
BR_area_codes[97] = ["AM","Tefe/Coari/Tabatinga/Manicore/Humaita/Labrea"]
BR_area_codes[98] = ["MA","Sao Luis/Sao Jose de Ribamar/Paco do Lumiar/Pinheiro/Santa Inês"]
BR_area_codes[99] = ["MA","Imperatriz/Caxias/Timon/Codo/Acailandia"]

class BR_Area_Code_Checker < Checker

	def initialize
		super
		@description = "List of Brazil area codes"
		@areas = {}
	end

	def process_word (word, extras = nil)
		if /([0-9]{3})$/.match(word)
			area_code = $1.to_i
			if BR_area_codes.has_key?(area_code)
				if !@areas.has_key?(area_code)
					@areas[area_code] = 1
				else
					@areas[area_code] += 1
				end
			end
		end
		@total_words_processed += 1
	end

	def get_results()
		ret_str = "Brazil Area Codes\n"

		if @areas.length > 0
			(@areas.sort do |x,y| (x[1] <=> y[1]) * -1 end).each do |area_code_data|
				ret_str << "#{area_code_data[0].to_s} #{BR_area_codes[area_code_data[0]][1]} (#{BR_area_codes[area_code_data[0]][0]}) = #{area_code_data[1].to_s} (#{((area_code_data[1].to_f/@total_words_processed) * 100).round(2).to_s}%)\n"
			end
		else
			ret_str << "None found\n"
		end

		return ret_str
	end
end
