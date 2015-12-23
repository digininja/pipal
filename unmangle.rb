module Unmangle
	def Unmangle.unmangle word
		unmangled = word.gsub("0", "o").gsub("3", "e")
		return unmangled
	end
end
