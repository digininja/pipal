# encoding: utf-8
register_checker("FR_Colour_Checker")

class FR_Colour_Checker < Checker
    @@colours = {"noir" => 0, "bleu" => 0, "maron" => 0, "gris" => 0, "vert" => 0,
	"orange" => 0, "rose" => 0, "rouge" => 0, "blanc" => 0, "jaune" => 0, 
	"violet" => 0, "indigo" => 0, "ocre" => 0, "cyan" => 0, "ocre" => 0}
    @@total_lines_processed = 0

    def process_word (line)
        @@colours.each_pair do |colour, count|
            if /#{colour}/i.match line
                @@colours[colour] += 1
            end
        end
        @@total_lines_processed += 1
    end

        def get_results()
            ret_str = "Couleurs\n"
            disp = false

            (@@colours.sort do |x,y| (x[1] <=> y[1]) * -1 end).each do |colour_data|
                unless colour_data[1] == 0
                    disp = true
                    ret_str << "#{colour_data[0]} = #{colour_data[1].to_s} (#{((colour_data[1].to_f/@@total_lines_processed) * 100).round(2).to_s}%)\n"
                end
            end
            unless disp
                ret_str << "Aucune trouvé\n"
            end

            return ret_str
	end
end
