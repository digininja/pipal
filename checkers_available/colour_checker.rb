register_checker("Colour_Checker")

class Colour_Checker < Checker
	@@colours = {"black" => 0, "blue" => 0, "brown" => 0, "gray" => 0, "green" => 0, "orange" => 0, "pink" => 0, "purple" => 0, "red" => 0, "white" => 0, "yellow" => 0, 'violet' => 0, 'indigo' => 0}
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
		ret_str = "Colours\n"
		disp = false

		(@@colours.sort do |x,y| (x[1] <=> y[1]) * -1 end).each do |colour_data|
			unless colour_data[1] == 0
				disp = true
				ret_str << "#{colour_data[0]} = #{colour_data[1].to_s} (#{((colour_data[1].to_f/@@total_lines_processed) * 100).round(2).to_s}%)\n"
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		return ret_str
	end
end
