# Written by Micah Hoffman (@webbreacher)

require_relative "../list_checker.rb"

register_checker("Emotion_Checker")

class Emotion_Checker < List_Checker
	def initialize
		super
		@description = "List of English emotional terms"
		@list = {
		            "angry" => 0,
		            "awesome" => 0,
		            "bad" => 0,
		            "beautiful" => 0,
		            "bored" => 0,
		            "confuse" => 0,
		            "crazy" => 0,
		            "envy" => 0,
		            "fear" => 0,
		            "good" => 0,
		            "great" => 0,
		            "happy" => 0,
		            "hate" => 0,
		            "heart" => 0,
		            "hope" => 0,
		            "hurt" => 0,
		            "insane" => 0,
		            "joy" => 0,
		            "kind" => 0,
		            "like" => 0,
		            "love" => 0,
		            "luv" => 0,
		            "pain" => 0,
		            "pity" => 0,
		            "sad" => 0,
		            "shame" => 0,
		            "tired" => 0,
		            "trust" => 0
		        }
	end

	def get_results()
		return super("Emotion")
	end
end
