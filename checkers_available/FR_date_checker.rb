# encoding: utf-8
register_checker("FR_Date_Checker")

class FR_Date_Checker < Checker
    def initialize
		super
		@description = "French day, month and year checker"
		
		#http://fr.wikipedia.org/wiki/Semaine (3ieres lettres)
		@days_ab = {'lun' => 0, 'mar' => 0, 'mer' => 0, 'jeu' => 0, 'ven' => 0, 'sam' => 0, 'dim' => 0}
		#http://fr.wikipedia.org/wiki/Mois#Abr.C3.A9viations
		@months_ab = {"janv" => 0, "fevr" => 0, "avr" => 0, "juill" => 0, 
		"sept" => 0, "oct" => 0, "nov" => 0, "dec" => 0}

		@days = {'lundi' => 0, 'mardi' => 0, 'mercredi' => 0, 'jeudi' => 0, 'vendredi' => 0, 'samedi' => 0, 'dimanche' => 0}
		@months = {"janvier" => 0, "fevrier" => 0, "mars" => 0, "avril" => 0, "mai" => 0, "juin" => 0, 
		"juillet" => 0, "aout" => 0, "septembre" => 0, "octobre" => 0, "novembre" => 0, "decembre" => 0}

		@years = {}

        1975.upto(2020) do |year|
            @years[year] = 0
        end
    end

    def process_word (line)
        @years.each_pair do |year, count|
            if /#{year}/.match line
                @years[year] += 1
            end
        end

        @days_ab.each_pair do |day, count|
            if /#{day}/i.match line
                @days_ab[day] += 1
            end
        end

        @months_ab.each_pair do |month, count|
            if /#{month}/i.match line
                @months_ab[month] += 1
            end
        end

        @days.each_pair do |day, count|
            if /#{day}/i.match line
                @days[day] += 1
            end
        end

        @months.each_pair do |month, count|
            if /#{month}/i.match line
                @months[month] += 1
            end
        end
        @total_lines_processed += 1
    end

    def get_results()
        ret_str = "Dates\n"

        ret_str << "\nMois\n"
        disp = false
        @months.each_pair do |month, count|
            unless count == 0
                disp = true
                ret_str << "#{month} = #{count.to_s} (#{((count.to_f/@total_lines_processed) * 100).round(2).to_s}%)\n" unless count == 0
            end
        end
        unless disp
            ret_str "Aucun trouvé\n"
        end

        ret_str << "\nJours\n"
        disp = false
        @days.each_pair do |day, count|
           unless count == 0
                disp = true
                ret_str << "#{day} = #{count.to_s} (#{((count.to_f/@total_lines_processed) * 100).round(2).to_s}%)\n" unless count == 0
           end
        end
        unless disp
            ret_str << "Aucun trouvé\n"
        end

        ret_str << "\nMois (Abréviation)\n"
        disp = false
        @months_ab.each_pair do |month, count|
            unless count == 0
                disp = true
                ret_str << "#{month} = #{count.to_s} (#{((count.to_f/@total_lines_processed) * 100).round(2).to_s}%)\n" unless count == 0
            end
        end
        unless disp
            ret_str << "Aucun trouvé\n"
        end

        ret_str << "\nJours (Abréviation)\n"
        disp = false
        @days_ab.each_pair do |day, count|
            unless count == 0
                disp = true
                ret_str << "#{day} = #{count.to_s} (#{((count.to_f/@total_lines_processed) * 100).round(2).to_s} %)\n" unless count == 0
            end
        end
        unless disp
            ret_str << "Aucun trouvé\n"
        end

        ret_str << "\nAnnées inclues\n"
        disp = false
        @years.each_pair do |number, count|
            unless count == 0
                disp = true
                ret_str << "#{number.to_s} = #{count.to_s} (#{((count.to_f/@total_lines_processed) * 100).round(2).to_s}%)\n" unless count == 0
            end
        end
        unless disp
            ret_str << "Aucune trouvée\n"
        end

        count_ordered = []
        @years.each_pair do |year, count|
            count_ordered << [year, count] unless count == 0
        end
        @years = count_ordered.sort do |x,y|
            (x[1] <=> y[1]) * -1
        end

        ret_str << "\nAnnées (Top #{@cap_at.to_s})\n"
        disp = false
        @years[0, @cap_at].each do |data|
            disp = true
            ret_str << "#{data[0].to_s} = #{data[1].to_s} (#{((data[1].to_f/@total_lines_processed) * 100).round(2).to_s}%)\n"
        end
        unless disp
            ret_str << "Aucune trouvée\n"
        end

        return ret_str
    end
end
