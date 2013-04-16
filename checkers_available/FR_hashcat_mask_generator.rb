# encoding: utf-8
register_checker("FR_Hashcat_Mask_Generator")

class FR_Hashcat_Mask_Generator < Checker
	@@hashcat_masks = {}

	def initialize
		super
		@description = "Hashcat mask generator (French)"
	end

	def process_word (line)
		# This won't work as the special replacement hits all the previous ?'s that have been replaced, 
		# lower at the end would do the same with all the characters so can't use the order to fix this problem
		# mask_line = line.gsub(/[a-z]/, "?l").gsub(/[A-Z]/,'?u').gsub(/[0-9]/, '?d').gsub(/[\p{Punct}]/, '?s')
		mask_line = ""
		line.each_char do |char|
			case char
				when /[a-z]/
					mask_line << "?l"
				when /[A-Z]/
					mask_line << "?u"
				when /[0-9]/
					mask_line << "?d"
				else
					mask_line << "?s"
			end
		end
		
		if !@@hashcat_masks.has_key? mask_line
			@@hashcat_masks[mask_line] = {'count' => 0}
		end
		@@hashcat_masks[mask_line]['count'] += 1
		@@total_lines_processed += 1
	end

	def get_results()
		ret_str = "Masques Hashcat (Top #{@cap_at.to_s})\n\n"

		count_ordered = []
		@@hashcat_masks.each_pair do |name, data|
			count_ordered << [name, data] unless data['count'] == 0
		end
		@@hashcat_masks = count_ordered.sort do |x,y|
			(x[1]['count'] <=> y[1]['count']) * -1
		end

		@@hashcat_masks[0, @cap_at].each do |name, data|
			ret_str << "#{name}: #{data['count'].to_s} (#{((data['count'].to_f/@@total_lines_processed) * 100).round(2).to_s}%)\n"
		end

		return ret_str
	end
end
