# encoding: utf-8

# Find out what our base path is
base_path = File.expand_path(File.dirname(__FILE__))
#require File.join(base_path, '../horizbar.rb')
register_checker("Deleet_Checker")

class Deleet_Checker < Checker
	def initialize
		super
		@words = {}
        @deleet_mapping = {
                    "1" =>  "i",
                    "0" =>  "o",
                    "4" =>  "a",
                    "5" =>  "s",
                    "@" =>  "a",
                  }
	end
	def process_word (word, extras = nil)
      word.downcase!
      @deleet_mapping.each {|before, after|
        word.tr!(before, after)
      }

      if !@words.has_key?(word)
          @words[word] = 0
      end
      @words[word] += 1
    end

    def get_results()
		ret_str = "Basic Results\n\n"
		ret_str <<  "Total entries = #{@total_words_processed.to_s}\n"
		uniq_words = @words.to_a.uniq
		ret_str << "Total unique entries = #{uniq_words.length.to_s}\n"
		uniq_words = Array.new(@words.to_a.uniq)

		ret_str << "\nTop #{@cap_at.to_s} passwords\n"
		# The default is to sort lowest to highest, the -1 just inverts that
		@words.sort{|a,b| (a[1]<=>b[1]) * -1}[0, @cap_at].each { |elem|
			percentage = (elem[1].to_f / @total_words_processed) * 100
			ret_str << "#{elem[0]} = #{elem[1].to_s} (#{percentage.round(2).to_s}%)\n"
		}
    end
end
