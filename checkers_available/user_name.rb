register_checker("Username_Checker")

begin
	require "levenshtein"
rescue LoadError
	# catch error and prodive feedback on installing gem
	puts "\nError: levenshtein gem not installed\n"
	puts "\t use: \"gem install levenshtein-ffi\" to install the required gem\n\n"
	exit
end

class Username_Checker < Checker

	def initialize
		super
		@exact_matches = []
		@lev_matches = []
		@lev_total = 0
		@lev_tolerance = 3

		@description = "Compare username to password"
		@cli_params = [['--username.lev_tolerance', GetoptLong::REQUIRED_ARGUMENT]]
	end

	def parse_params opts
		opts.each do |opt, arg|
			case opt
				when '--username.lev_tolerance'
				if arg =~ /^[0-9]*$/
					@lev_tolerance = arg.to_i
					if @lev_tolerance <= 0
						puts"\nUsername Checker: Please enter a positive distance\n\n"
						exit 1
					end
				else
					puts"\nUsername Checker: Invalid Levenshtein tolerance\n\n"
					exit 1
				end
			end
		end
	end

	def process_word (word, extras = nil)
		if extras.has_key?("username")
			username = extras['username']

			if word == username
				@exact_matches << word
			else
				dist = Levenshtein.distance(word, username)
				puts "Lev distance #{dist}#" if @verbose
				@lev_total += dist
				if dist <= @lev_tolerance
					@lev_matches << {"distance" => dist, "username" => username, "password" => word}
				end
			end
		end

		@total_words_processed += 1
	end

	def get_results()
		ret_str = "Username Test\n"

		ret_str << "Exact Matches\n"
		if @exact_matches.count > 0
			@exact_matches.each do |match|
				ret_str << "#{match}\n"
			end
		else
			ret_str << "No Exact Matches\n"
		end

		ret_str << "\nLevenshtein Results\n"
		lev_average = (@lev_total.to_f / @total_words_processed).round(2)
		ret_str << "Average distance #{lev_average}\n"

		ret_str << "Close Matches\n"

		# Need to sort this then have it obey the cap_at value
		if @lev_matches.count > 0
			@lev_matches.sort{|a,b| (a['distance'] <=> b['distance'])}[0, @cap_at].each do |user_pass|
				ret_str << "D: #{user_pass['distance']} U: #{user_pass['username']} P: #{user_pass['password']}\n"
			end
		else
			ret_str << "No matches within supplied tolerance\n"
		end

		return ret_str
	end
end
