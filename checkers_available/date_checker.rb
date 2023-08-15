register_checker("Date_Checker")

class Date_Checker < Checker

	def initialize
		super

		@years = {}
		1975.upto(2030) do |year|
			@years[year] = 0
		end

		@days_ab = {'mon' => 0, 'tues' => 0, 'wed' => 0, 'thurs' => 0, 'fri' => 0, 'sat' => 0, 'sun' => 0}
		@months_ab = {"jan" => 0, "feb" => 0, "mar" => 0, "apr" => 0, "may" => 0, "jun" => 0, "jul" => 0, "aug" => 0, "sept" => 0, "oct" => 0, "nov" => 0, "dec" => 0}

		@days = {'monday' => 0, 'tuesday' => 0, 'wednesday' => 0, 'thursday' => 0, 'friday' => 0, 'saturday' => 0, 'sunday' => 0}
		@months = {"january" => 0, "february" => 0, "march" => 0, "april" => 0, "may" => 0, "june" => 0, "july" => 0, "august" => 0, "september" => 0, "october" => 0, "november" => 0, "december" => 0}
		@description = "Days, months and years"
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

	def freq_sort(data)
		count_ordered = []
		data.each_pair do |val, count|
			count_ordered << [val, count] unless count == 0
		end
		freqs_sorted = count_ordered.sort do |x,y|
			(x[1] <=> y[1]) * -1
		end
        return freqs_sorted
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
			ret_str << "None found\n"
		end
		
        months_sorted = freq_sort(@months)

		ret_str << "\nMonths (Frequency ordered)\n"
		disp = false
		months_sorted.each do |data|
			month = data[0]
			count = data[1]
			unless count == 0
				disp = true
				ret_str << "#{month} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "None found\n"
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

        days_sorted = freq_sort(@days)

		ret_str << "\nDays (Frequency ordered)\n"
		disp = false
		days_sorted.each do |data|
			day = data[0]
			count = data[1]
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

		months_ab_sorted = freq_sort(@months_ab)

		ret_str << "\nMonths (Abreviated) (Frequency ordered)\n"
		disp = false
		months_ab_sorted.each do |data|
			month = data[0]
			count = data[1]
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

		days_ab_sorted = freq_sort(@days_ab)

		ret_str << "\nDays (Abreviated) (Frequency ordered)\n"
		disp = false
		days_ab_sorted.each do |data|
			day = data[0]
			count = data[1]
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

		years_freq_sort = freq_sort(@years)

		ret_str << "\nYears (Top #{@cap_at.to_s})\n"
		disp = false
		years_freq_sort[0, @cap_at].each do |data|
			disp = true
			ret_str << "#{data[0].to_s} = #{data[1].to_s} (#{((data[1].to_f/@total_words_processed) * 100).round(2).to_s}%)\n"
		end
		unless disp
			ret_str << "None found\n"
		end

		return ret_str
	end
end
