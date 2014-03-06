register_checker("Hashcat_Mask_Generator")

class Hashcat_Mask_Generator < Checker
	@override_cap = false

	def initialize
		super
		@description = "Hashcat mask generator"
		@hashcat_masks = {}
		@cli_params = [['--hashcat.all', GetoptLong::NO_ARGUMENT]]
	end

	def usage
		return "\t--hashcat.all: return Hashcat masks for all passwords\n\t\t\tThis overrides --top"
	end

	def parse_params opts
		opts.each do |opt, arg|
			case opt
				when '--hashcat.all'
					@override_cap = true
			end
		end
	end

	def process_word (word, extras = nil)
		# This won't work as the special replacement hits all the previous ?'s that have been replaced, 
		# lower at the end would do the same with all the characters so can't use the order to fix this problem
		# mask_line = line.gsub(/[a-z]/, "?l").gsub(/[A-Z]/,'?u').gsub(/[0-9]/, '?d').gsub(/[\p{Punct}]/, '?s')
		mask_line = ""
		word.each_char do |char|
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
		
		if !@hashcat_masks.has_key? mask_line
			@hashcat_masks[mask_line] = {'count' => 0}
		end
		@hashcat_masks[mask_line]['count'] += 1
		@total_words_processed += 1
	end

	def get_results()
		if @override_cap
			@cap_at = @hashcat_masks.length
			ret_str = "Hashcat masks\n\n"
		else
			ret_str = "Hashcat masks (Top #{@cap_at.to_s})\n\n"
		end

		count_ordered = []
		@hashcat_masks.each_pair do |name, data|
			count_ordered << [name, data] unless data['count'] == 0
		end
		@hashcat_masks = count_ordered.sort do |x,y|
			(x[1]['count'] <=> y[1]['count']) * -1
		end

		@hashcat_masks[0, @cap_at].each do |name, data|
			ret_str << "#{name}: #{data['count'].to_s} (#{((data['count'].to_f/@total_words_processed) * 100).round(2).to_s}%)\n"
		end

		return ret_str
	end
end
