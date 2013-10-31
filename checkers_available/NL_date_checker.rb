register_checker("Date_Checker")

class Date_Checker < Checker

	def initialize
		super

		@years = {}
		1975.upto(2020) do |year|
			@years[year] = 0
		end

		@days_ab = {'maa' => 0, 'din' => 0, 'woe' => 0, 'don' => 0, 'vrij' => 0, 'zat' => 0, 'zon' => 0}
		@months_ab = {"jan" => 0, "feb" => 0, "mrt" => 0, "apr" => 0, "mei" => 0, "jun" => 0, "jul" => 0, "aug" => 0, "sep" => 0, "okt" => 0, "nov" => 0, "dec" => 0}

		@days = {'maandag' => 0, 'dinsdag' => 0, 'woensdag' => 0, 'donderdag' => 0, 'vrijdag' => 0, 'zaterdag' => 0, 'zondag' => 0}
		@months = {"januari" => 0, "februari" => 0, "maart" => 0, "april" => 0, "mei" => 0, "juni" => 0, "juli" => 0, "augustus" => 0, "september" => 0, "oktober" => 0, "november" => 0, "december" => 0}
		@description = "Dutch day, month and year checker"
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
		ret_str = "Dates\n"

		ret_str << "\nMonths\n"
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

		ret_str << "\nDays\n"
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

		ret_str << "\nMonths (Abreviated)\n"
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

		ret_str << "\nDays (Abreviated)\n"
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
