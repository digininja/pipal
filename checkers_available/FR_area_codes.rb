# encoding: utf-8
register_checker("FR_area_Code_Checker")

FR_area_codes = {}

#http://fr.wikipedia.org/wiki/Code_officiel_g%C3%A9ographique
#The hashcode is a string because 0x is the octal notation and bug with 08 and 09
FR_area_codes["01"] = ["Ain"]
FR_area_codes["02"] = ["Aisne"]
FR_area_codes["03"] = ["Allier"]
FR_area_codes["04"] = ["Alpes-de-Haute-Provence"]
FR_area_codes["05"] = ["Hautes-Alpes"]
FR_area_codes["06"] = ["Alpes-Maritimes"]
FR_area_codes["07"] = ["Ardèche"]
FR_area_codes["08"] = ["Ardennes"]
FR_area_codes["09"] = ["Ariège"]
FR_area_codes["10"] = ["Aube"]
FR_area_codes["11"] = ["Aude"]
FR_area_codes["12"] = ["Aveyron"]
FR_area_codes["13"] = ["Bouches-du-Rhône"]
FR_area_codes["14"] = ["Calvados"]
FR_area_codes["15"] = ["Cantal"]
FR_area_codes["16"] = ["Charente"]
FR_area_codes["17"] = ["Charente-Maritime"]
FR_area_codes["18"] = ["Cher"]
FR_area_codes["19"] = ["Corrèze"]
#FR_area_codes["2A"] = ["Corse-du-Sud"]
#FR_area_codes["2B"] = ["Haute-Corse"]
FR_area_codes["21"] = ["Côte-d’Or"]
FR_area_codes["22"] = ["Côtes-d’Armor"]
FR_area_codes["23"] = ["Creuse"]
FR_area_codes["24"] = ["Dordogne"]
FR_area_codes["25"] = ["Doubs"]
FR_area_codes["26"] = ["Drôme"]
FR_area_codes["27"] = ["Eure"]
FR_area_codes["28"] = ["Eure-et-Loir"]
FR_area_codes["29"] = ["Finistère"]
FR_area_codes["30"] = ["Gard"]
FR_area_codes["31"] = ["Haute-Garonne"]
FR_area_codes["32"] = ["Gers"]
FR_area_codes["33"] = ["Gironde"]
FR_area_codes["34"] = ["Hérault"]
FR_area_codes["35"] = ["Ille-et-Vilaine"]
FR_area_codes["36"] = ["Indre"]
FR_area_codes["37"] = ["Indre-et-Loire"]
FR_area_codes["38"] = ["Isère"]
FR_area_codes["39"] = ["Jura"]
FR_area_codes["40"] = ["Landes"]
FR_area_codes["41"] = ["Loir-et-Cher"]
FR_area_codes["42"] = ["Loire"]
FR_area_codes["43"] = ["Haute-Loire"]
FR_area_codes["44"] = ["Loire-Atlantique"]
FR_area_codes["45"] = ["Loiret"]
FR_area_codes["46"] = ["Lot"]
FR_area_codes["47"] = ["Lot-et-Garonne"]
FR_area_codes["48"] = ["Lozère"]
FR_area_codes["49"] = ["Maine-et-Loire"]
FR_area_codes["50"] = ["Manche"]
FR_area_codes["51"] = ["Marne"]
FR_area_codes["52"] = ["Haute-Marne"]
FR_area_codes["53"] = ["Mayenne"]
FR_area_codes["54"] = ["Meurthe-et-Moselle"]
FR_area_codes["55"] = ["Meuse"]
FR_area_codes["56"] = ["Morbihan"]
FR_area_codes["57"] = ["Moselle"]
FR_area_codes["58"] = ["Nièvre"]
FR_area_codes["59"] = ["Nord"]
FR_area_codes["60"] = ["Oise"]
FR_area_codes["61"] = ["Orne"]
FR_area_codes["62"] = ["Pas-de-Calais"]
FR_area_codes["63"] = ["Puy-de-Dôme"]
FR_area_codes["64"] = ["Pyrénées-Atlantiques"]
FR_area_codes["65"] = ["Hautes-Pyrénées"]
FR_area_codes["66"] = ["Pyrénées-Orientales"]
FR_area_codes["67"] = ["Bas-Rhin"]
FR_area_codes["68"] = ["Haut-Rhin"]
FR_area_codes["69"] = ["Rhône"]
FR_area_codes["70"] = ["Haute-Saône"]
FR_area_codes["71"] = ["Saône-et-Loire"]
FR_area_codes["72"] = ["Sarthe"]
FR_area_codes["73"] = ["Savoie"]
FR_area_codes["74"] = ["Haute-Savoie"]
FR_area_codes["75"] = ["Paris"]
FR_area_codes["76"] = ["Seine-Maritime"]
FR_area_codes["77"] = ["Seine-et-Marne"]
FR_area_codes["78"] = ["Yvelines"]
FR_area_codes["79"] = ["Deux-Sèvres"]
FR_area_codes["80"] = ["Somme"]
FR_area_codes["81"] = ["Tarn"]
FR_area_codes["82"] = ["Tarn-et-Garonne"]
FR_area_codes["83"] = ["Var"]
FR_area_codes["84"] = ["Vaucluse"]
FR_area_codes["85"] = ["Vendée"]
FR_area_codes["86"] = ["Vienne"]
FR_area_codes["87"] = ["Haute-Vienne"]
FR_area_codes["88"] = ["Vosges"]
FR_area_codes["89"] = ["Yonne"]
FR_area_codes["90"] = ["Territoire de Belfort"]
FR_area_codes["91"] = ["Essonne"]
FR_area_codes["92"] = ["Hauts-de-Seine"]
FR_area_codes["93"] = ["Seine-Saint-Denis"]
FR_area_codes["94"] = ["Val-de-Marne"]
FR_area_codes["95"] = ["Val-d’Oise"]
FR_area_codes["97"] = ["Collectivités d’outre-mer"]
#FR_area_codes["971"] = ["Guadeloupe"]
#FR_area_codes["972"] = ["Martinique"]
#FR_area_codes["973"] = ["Guyane"]
#FR_area_codes["974"] = ["La Réunion"]
#FR_area_codes["976"] = ["Mayotte"]
FR_area_codes["98"] = ["Collectivités d’outre-mer"]

class FR_area_Code_Checker < Checker
    @areas = {}

	def initialize
		super
		@description = "List of French area codes"
	end

    def process_word (line)
        if /(^([0-9]{5})|([0-9]{5})$)/.match(line)
            #to many matchs with 01234 or 98765 or 11111, etc.
            if !((($1[0].to_i == $1[1].to_i + 1) and ($1[1].to_i == $1[2].to_i + 1) and
		($1[2].to_i == $1[3].to_i + 1) and ($1[3].to_i == $1[4].to_i + 1)) or
 		(($1[0].to_i == $1[1].to_i - 1) and ($1[1].to_i == $1[2].to_i - 1) and 
		($1[2].to_i == $1[3].to_i - 1) and ($1[3].to_i == $1[4].to_i - 1)) or
		(($1[0].to_i == $1[1].to_i) and ($1[1].to_i == $1[2].to_i) and
		($1[2].to_i == $1[3].to_i) and ($1[3].to_i == $1[4].to_i)))
                area_code = $1[0,2]
                if FR_area_codes.has_key?(area_code)
                    if !@areas.has_key?(area_code)
                        @areas[area_code] = 1
                    else
                        @areas[area_code] += 1
                    end
                end
            end
        end
        @total_lines_processed += 1
    end

    def get_results()
        ret_str = "Départements français\n"

        if @areas.length > 0
            (@areas.sort do |x,y| (x[1] <=> y[1]) * -1 end).each do |area_code_data|
                ret_str << "#{area_code_data[0].to_s} #{FR_area_codes[area_code_data[0]][1]} (#{FR_area_codes[area_code_data[0]][0]}) = #{area_code_data[1].to_s} (#{((area_code_data[1].to_f/@total_lines_processed) * 100).round(2).to_s}%)\n"
            end
        else
            ret_str << "Aucun trouvé\n"
        end

        return ret_str
    end
end

