# encoding: utf-8
register_checker("FR_Windows_Complexity_Checker")

class FR_Windows_Complexity_Checker < Checker
	@@matches = 0

	def initialize
		super
		@description = "Check for default Windows complexity (French)"
	end

	def process_word (line)

		if line =~ /(?=^.{8,255}$)((?=.*\d)(?=.*[A-Z])(?=.*[a-z])|(?=.*\d)(?=.*[^A-Za-z0-9])(?=.*[a-z])|(?=.*[^A-Za-z0-9])(?=.*[A-Z])(?=.*[a-z])|(?=.*\d)(?=.*[A-Z])(?=.*[^A-Za-z0-9]))^.*/
			@@matches += 1
		end
		@@total_lines_processed += 1
	end

	def get_results()
		ret_str = "Complexité par défaut Active Directory\n"

		ret_str << "Number of matches = #{@@matches} (#{((@@matches.to_f/@@total_lines_processed) * 100).round(2).to_s}%)\n"
		return ret_str
	end
end
