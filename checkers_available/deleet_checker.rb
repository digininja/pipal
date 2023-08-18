# encoding: utf-8

# Find out what our base path is
base_path = File.expand_path(File.dirname(__FILE__))
register_checker("DeLeet_Checker")

class DeLeet_Checker < Checker
	def initialize
		super
		@words = {}
        @deleet_mapping = {
                    "0" =>  "o",
                    "1" =>  "i",
                    "3" =>  "e",
                    "4" =>  "a",
                    "5" =>  "s",
                    "@" =>  "a",
                  }
		@description = "Turn leet numbers back to alpha characters."
	end

	def process_word (word, extras = nil)
      word.downcase!
      # One of these !'s may not be necessary, but being cautious
      word = word.gsub!(/^[^a-z]*/, "").gsub!(/[^a-z]*$/, '')
      if word != ""
        @deleet_mapping.each {|before, after|
          word.tr!(before, after)
        }

        if !@words.has_key?(word)
            @words[word] = 0
        end
        @words[word] += 1
      end

      @total_words_processed += 1
    end

    def get_results()
		ret_str = "DeLeet Results\n\n"
		ret_str <<  "Total entries = #{@words.count.to_s}\n"

		ret_str << "\nTop #{@cap_at.to_s} passwords\n"
		# The default is to sort lowest to highest, the -1 just inverts that
		@words.sort{|a,b| (a[1]<=>b[1]) * -1}[0, @cap_at].each { |elem|
			percentage = (elem[1].to_f / @total_words_processed) * 100
			ret_str << "#{elem[0]} = #{elem[1].to_s} (#{percentage.round(2).to_s}%)\n"
		}
        return ret_str
    end
end
