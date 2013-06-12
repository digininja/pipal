# Split the line on a pipe with the format
# password|username
#
# To use this script sym link it to
# custom_splitter.rb in the main Pipal directory

class Custom_word_splitter
	def self.split (line)
		if line =~ /^([^|]*)\|(.*)$/
			word = $1
			username = $2

			return [word, {"username" => username}]
		end
		return [line, {}]
	end
end
