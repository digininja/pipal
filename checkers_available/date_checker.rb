register_checker("Date_Checker")

class Date_Checker < Checker
	@@total_lines_processed = 0
	@@days_ab = {'mon' => 0, 'tues' => 0, 'wed' => 0, 'thurs' => 0, 'fri' => 0, 'sat' => 0, 'sun' => 0}
	@@months_ab = {"jan" => 0, "feb" => 0, "mar" => 0, "apr" => 0, "may" => 0, "jun" => 0, "jul" => 0, "aug" => 0, "sept" => 0, "oct" => 0, "nov" => 0, "dec" => 0}

	@@days = {'monday' => 0, 'tuesday' => 0, 'wednesday' => 0, 'thursday' => 0, 'friday' => 0, 'saturday' => 0, 'sunday' => 0}
	@@months = {"january" => 0, "february" => 0, "march" => 0, "april" => 0, "may" => 0, "june" => 0, "july" => 0, "august" => 0, "september" => 0, "october" => 0, "november" => 0, "december" => 0}

	@@years = {}

	@@cap_at = 10

	def initialize
		1975.upto(2020) do |year|
			@@years[year] = 0
		end
	end

	def process_word (line)
		@@years.each_pair do |year, count|
			if /#{year}/.match line
				@@years[year] += 1
			end
		end

		@@days_ab.each_pair do |day, count|
			if /#{day}/i.match line
				@@days_ab[day] += 1
			end
		end

		@@months_ab.each_pair do |month, count|
			if /#{month}/i.match line
				@@months_ab[month] += 1
			end
		end

		@@days.each_pair do |day, count|
			if /#{day}/i.match line
				@@days[day] += 1
			end
		end

		@@months.each_pair do |month, count|
			if /#{month}/i.match line
				@@months[month] += 1
			end
		end
		@@total_lines_processed += 1
	end

	def get_results()
		ret_str = "Dates\n"

		ret_str << "\nMonths\n"
		disp = false
		@@months.each_pair do |month, count|
			unless count == 0
				disp = true
				ret_str << "#{month} = #{count.to_s} (#{((count.to_f/@@total_lines_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str "None found\n"
		end

		ret_str << "\nDays\n"
		disp = false
		@@days.each_pair do |day, count|
			unless count == 0
				disp = true
				ret_str << "#{day} = #{count.to_s} (#{((count.to_f/@@total_lines_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		ret_str << "\nMonths (Abreviated)\n"
		disp = false
		@@months_ab.each_pair do |month, count|
			unless count == 0
				disp = true
				ret_str << "#{month} = #{count.to_s} (#{((count.to_f/@@total_lines_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		ret_str << "\nDays (Abreviated)\n"
		disp = false
		@@days_ab.each_pair do |day, count|
			unless count == 0
				disp = true
				ret_str << "#{day} = #{count.to_s} (#{((count.to_f/@@total_lines_processed) * 100).round(2).to_s} %)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		ret_str << "\nIncludes years\n"
		disp = false
		@@years.each_pair do |number, count|
			unless count == 0
				disp = true
				ret_str << "#{number.to_s} = #{count.to_s} (#{((count.to_f/@@total_lines_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		count_ordered = []
		@@years.each_pair do |year, count|
			count_ordered << [year, count] unless count == 0
		end
		@@years = count_ordered.sort do |x,y|
			(x[1] <=> y[1]) * -1
		end

		ret_str << "\nYears (Top #{@@cap_at.to_s})\n"
		disp = false
		@@years[0, @@cap_at].each do |data|
			disp = true
			ret_str << "#{data[0].to_s} = #{data[1].to_s} (#{((data[1].to_f/@@total_lines_processed) * 100).round(2).to_s}%)\n"
		end
		unless disp
			ret_str << "None found\n"
		end

		return ret_str
	end
end
