register_checker("Date_Checker")

class Date_Checker < Checker

	def initialize
		super

		@years = {}
		1975.upto(2020) do |year|
			@years[year] = 0
		end

		@days_ab = { 'mon' => 0, 'tues' => 0, 'wed' => 0, 'thurs' => 0, 'fri' => 0, 'sat' => 0, 'sun' => 0}
		@months_ab = {"jan" => 0, "feb" => 0, "mar" => 0, "apr" => 0, "may" => 0, "jun" => 0, "jul" => 0, "aug" => 0, "sept" => 0, "oct" => 0, "nov" => 0, "dec" => 0}

		@days = { 'monday' => 0, 'tuesday' => 0, 'wednesday' => 0, 'thursday' => 0, 'friday' => 0, 'saturday' => 0, 'sunday' => 0}
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
		data = get_json_results

		ret_str = "Dates\n"

		ret_str << "\nMonths\n"
		if !data['Months'].nil?
			ret_str << print_entries(data['Months'])
		else
			ret_str << "None found\n"
		end

		ret_str << "\nMonths (Frequency ordered)\n"
		if !data['Months'].nil?
			ret_str << print_entries(data['Months'].sort{|a,b|(b[1]['count'] <=> a[1]['count'])})
		else
			ret_str << "None found\n"
		end

		ret_str << "\nDays\n"
		if !data['Days'].nil?
			ret_str << print_entries(data['Days'])
		else
			ret_str << "None found\n"
		end

		ret_str << "\nDays (Frequency ordered)\n"
		if !data['Days'].nil?
			ret_str << print_entries(data['Days'].sort{|a,b|(b[1]['count'] <=> a[1]['count'])})
		else
			ret_str << "None found\n"
		end

		ret_str << "\nMonths (Abreviated)\n"
		if !data['Months_(Abreviated)'].nil?
			ret_str << print_entries(data['Months_(Abreviated)'])
		else
			ret_str << "None found\n"
		end

		ret_str << "\nMonths (Abreviated) (Frequency ordered)\n"
		if !data['Months_(Abreviated)'].nil?
			ret_str << print_entries(data['Months_(Abreviated)'].sort{|a,b|(b[1]['count'] <=> a[1]['count'])})
		else
			ret_str << "None found\n"
		end

		ret_str << "\nDays (Abreviated)\n"
		if !data['Days_(Abreviated)'].nil?
			ret_str << print_entries(data['Days_(Abreviated)'])
		else
			ret_str << "None found\n"
		end

		ret_str << "\nDays (Abreviated) (Frequency ordered)\n"
		if !data['Days_(Abreviated)'].nil?
			ret_str << print_entries(data['Days_(Abreviated)'].sort{|a,b|(b[1]['count'] <=> a[1]['count'])})
		else
			ret_str << "None found\n"
		end

		ret_str << "\nIncludes years\n"
		if !data['Years'].nil?
			ret_str << print_entries(data['Years'])
		else
			ret_str << "None found\n"
		end

		ret_str << "\nYears (Top #{@cap_at.to_s})\n"
		if !data["Years_(Top #{@cap_at})"].nil?
			ret_str << print_entries(data["Years_(Top #{@cap_at})"])
		else
			ret_str << "None found\n"
		end

		return ret_str
	end

	def get_json_results()
		result = {}

		months = {}
		@months.each_pair do |month, count|
			months[month] = { 'count' => count, 'percentage' => ((count.to_f/@total_words_processed) * 100).round(2) } unless count.zero?
		end
		result['Months'] = months

		days = {}
		@days.each_pair do |day, count|
			days[day] = { 'count' => count, 'percentage' => ((count.to_f/@total_words_processed) * 100).round(2) } unless count.zero?
		end
		result['Days'] = days

		months_ab = {}
		@months_ab.each_pair do |month, count|
			months_ab[month] = { 'count' => count, 'percentage' => ((count.to_f/@total_words_processed) * 100).round(2) } unless count.zero?
		end
		result['Months_(Abreviated)'] = months_ab

		days_ab = {}
		@days_ab.each_pair do |day, count|
			days_ab[day] = { 'count' => count, 'percentage' => ((count.to_f/@total_words_processed) * 100).round(2) } unless count.zero?
		end
		result['Days_(Abreviated)'] = days_ab

		years = {}

		@years.each_pair do |number, count|
			years[number] = { 'count' => count, 'percentage' => ((count.to_f/@total_words_processed) * 100).round(2) } unless count.zero?
		end
		result['Years'] = years

		years_freq_sort = freq_sort(@years)

		years_top_ten = {}
		years_freq_sort[0, @cap_at].each do |data|
			years_top_ten[data[0]] = { 'count'=>data[1], 'percentage' => ((data[1].to_f/@total_words_processed) * 100).round(2) }
		end
		result["Years_(Top #{@cap_at})"] = years_top_ten

		return result
	end
end
