# PT-BR version by Daniel Marques (@0xc0da)

register_checker("PTBR_Date_Checker")

class PTBR_Date_Checker < Checker

	def initialize
		super

		@years = {}
		1975.upto(2020) do |year|
			@years[year] = 0
		end

		@days_ab = {'seg' => 0, 'ter' => 0, 'qua' => 0, 'qui' => 0, 'sex' => 0, 'sab' => 0, 'dom' => 0}
		@months_ab = {"jan" => 0, "fev" => 0, "mar" => 0, "abr" => 0, "mai" => 0, "jun" => 0, "jul" => 0, "ago" => 0, "set" => 0, "out" => 0, "nov" => 0, "dez" => 0}

		@days = {'segunda' => 0, 'terca' => 0, 'quarta' => 0, 'quinta' => 0, 'sexta' => 0, 'sabado' => 0, 'domingo' => 0}
		@months = {"janeiro" => 0, "fevereiro" => 0, "marco" => 0, "abril" => 0, "maio" => 0, "junho" => 0, "julho" => 0, "agosto" => 0, "setembro" => 0, "outubro" => 0, "novembro" => 0, "dezembro" => 0}
		@description = "Brazilian Portuguese day, month and year checker"
	end

	def process_word (word, extras = nil)
		@years.each_pair do |year, count|
			if /#{year}/.match word
				@years[year] += 1
			end
		end

		@days_ab.each_pair do |day, count|
			if /#{day}/i.match word
				@days_ab[day] += 1
			end
		end

		@months_ab.each_pair do |month, count|
			if /#{month}/i.match word
				@months_ab[month] += 1
			end
		end

		@days.each_pair do |day, count|
			if /#{day}/i.match word
				@days[day] += 1
			end
		end

		@months.each_pair do |month, count|
			if /#{month}/i.match word
				@months[month] += 1
			end
		end
		@total_words_processed += 1
	end

	def get_results()
		ret_str = "Brazilian Portuguese Dates\n"

		ret_str << "\nBrazilian Portuguese Months\n"
		disp = false
		@months.each_pair do |month, count|
			unless count == 0
				disp = true
				ret_str << "#{month} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str = "None found\n"
		end

		ret_str << "\nBrazilian Portuguese Days\n"
		disp = false
		@days.each_pair do |day, count|
			unless count == 0
				disp = true
				ret_str << "#{day} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		ret_str << "\nBrazilian Portuguese Months (Abreviated)\n"
		disp = false
		@months_ab.each_pair do |month, count|
			unless count == 0
				disp = true
				ret_str << "#{month} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		ret_str << "\nBrazilian Portuguese Days (Abreviated)\n"
		disp = false
		@days_ab.each_pair do |day, count|
			unless count == 0
				disp = true
				ret_str << "#{day} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s} %)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		ret_str << "\nIncludes years\n"
		disp = false
		@years.each_pair do |number, count|
			unless count == 0
				disp = true
				ret_str << "#{number.to_s} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		count_ordered = []
		@years.each_pair do |year, count|
			count_ordered << [year, count] unless count == 0
		end
		@years = count_ordered.sort do |x,y|
			(x[1] <=> y[1]) * -1
		end

		ret_str << "\nYears (Top #{@cap_at.to_s})\n"
		disp = false
		@years[0, @cap_at].each do |data|
			disp = true
			ret_str << "#{data[0].to_s} = #{data[1].to_s} (#{((data[1].to_f/@total_words_processed) * 100).round(2).to_s}%)\n"
		end
		unless disp
			ret_str << "None found\n"
		end

		return ret_str
	end
end
