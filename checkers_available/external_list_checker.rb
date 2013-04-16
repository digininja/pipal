register_checker("External_List_Checker")

class External_List_Checker < Checker
	@@external_list = {}
	@@file_name = 'ext'
	#@@file_name = nil

	def initialize
		super
		@description = "Check an external file for matches"

		if !@@file_name.nil?
			if File.exist?(@@file_name)
				begin
					File.open(@@file_name, 'r').each_line do |word|
						@@external_list[word.force_encoding("ASCII-8BIT").strip] = 0 unless word.force_encoding("ASCII-8BIT").strip == ''
					end
				rescue Errno::EACCES => e
					raise PipalException.new("Unable to open external file")
				end
			else
				raise PipalException.new("Unable to open external file")
			end
		end
	end

	def process_word (line)
		@@external_list.each_pair do |domain, count|
			if /#{Regexp.quote(domain)}/i.match line
				@@external_list[domain] += 1
			end
		end

		@@total_lines_processed += 1
	end

	def get_results()
		if @@external_list.length > 0
			count_ordered = []
			@@external_list.each_pair do |domain, count|
				count_ordered << [domain, count] unless count == 0
			end
			@@external_list = count_ordered.sort do |x,y|
				(x[1] <=> y[1]) * -1
			end

			ret_str = "External list (Top #{@cap_at.to_s})\n"
			disp = false
			@@external_list[0, @cap_at].each do |data|
				disp = true
				ret_str << "#{data[0]} = #{data[1].to_s} (#{((data[1].to_f/@@total_lines_processed) * 100).round(2).to_s}%)\n"
			end
			unless disp
				ret_str << "None found\n"
			end
		end

		return ret_str
	end
end
