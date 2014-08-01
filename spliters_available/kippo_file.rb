# Split the line on a pipe with the format
# password|username
#
# To use this script sym link it to
# custom_splitter.rb in the main Pipal directory

class Custom_word_splitter
	def self.split (line)
		begin

# 2014-07-31 15:37:17+0100 [SSHService ssh-userauth on HoneyPotTransport,1,2.123.133.112] login attempt [root/root] failed
			if line =~ /^.*login attempt \[([^\]]*)\].*$/
				creds = $1
				# Treat everything up to the first / as username and 
				# everything after as password.
				# A username could have a / in it but unlikely
				if creds =~ /^([^\/]*)\/(.*)$/
					username = $1
					password = $2
					return [password, {"username" => username}]
				end
			end

			return [nil, {}]
		rescue
			return [nil, {}]
		end
	end
end
