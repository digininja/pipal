register_checker("Unmangle_Checker")

class Unmangle_Checker < Checker

	def initialize
		super
		@matches = {}

		@description = "Demoing unmangling."
	end

	def process_word (password, extras, unmangled)
		if not @matches.has_key? password
			@matches[password] = {:exact => 0, :unmangled => 0}
		end
		@matches[password][:exact] += 1

		if @matches.has_key? unmangled
			@matches[password][:unmangled] += 1
		end

		@total_words_processed += 1
	end

	def get_results()
		ret_str =  "Unmangle Demo\n"
		ret_str << "=============\n\n"

		# Need to sort this then have it obey the cap_at value (if not ignored)
		if @ignore_cap
			@cap_at = @matches.count
		end

		ret_str << "Total Words: #{@matches.count.to_s} Unique\n\n"

		ret_str << "Exact Matches\n"
		ret_str << "-------------\n"

		@matches.sort_by { |k, v| v[:exact]}[0, @cap_at].each do |match|
			ret_str << "#{match[0]}: #{match[1][:exact]}\n"
		end

		ret_str << "\n"
		ret_str << "Unmangled Matches\n"
		ret_str << "-----------------\n"

		@matches.sort_by { |k, v| v[:unmanged]}[0, @cap_at].each do |match|
			ret_str << "#{match[0]}: #{match[1][:unmangled]}\n"
		end

		return ret_str
	end
end
