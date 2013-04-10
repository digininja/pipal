register_checker("Windows_Complexity_Checker")

class Windows_Complexity_Checker < Checker
	@@matches = 0

	def process_word (line)

		if line =~ /(?=^.{8,255}$)((?=.*\d)(?=.*[A-Z])(?=.*[a-z])|(?=.*\d)(?=.*[^A-Za-z0-9])(?=.*[a-z])|(?=.*[^A-Za-z0-9])(?=.*[A-Z])(?=.*[a-z])|(?=.*\d)(?=.*[A-Z])(?=.*[^A-Za-z0-9]))^.*/
			@@matches += 1
		end
	end

	def get_results(total_lines_processed)
		ret_str = "Windows AD Default Complexity\n"

		ret_str << "Number of matches = #{@@matches} (#{((@@matches.to_f/total_lines_processed) * 100).round(2).to_s}%)\n"
		return ret_str
	end
end
