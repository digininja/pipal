# Split the line on a pipe with the format
# password|username

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
