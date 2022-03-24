# Split the line on a colon with the format
# username:password
# useful if you're handling output from 
# hashcat --username --outfile-format=2 options
# and want to use the username checker.
#
# To use this script sym link it to
# custom_splitter.rb in the main Pipal directory

class Custom_word_splitter
	def self.split (line)
		if line =~ /^([^:]*)\:(.*)$/
			username = $1
      word = $2

			return [word, {"username" => username}]
		end
		return [line, {}]
	end
end
