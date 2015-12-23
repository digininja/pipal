require_relative "../list_checker.rb"

register_checker("Colour_Checker")

class Colour_Checker < List_Checker
	def initialize
		super
		@description = "List of common English colours"
		@list = {"black" => {:count => 0, :context => {}}, "blue" => {:count => 0, :context => {}}, "brown" => {:count => 0, :context => {}}, "gray" => {:count => 0, :context => {}}, "green" => {:count => 0, :context => {}}, "orange" => {:count => 0, :context => {}}, "pink" => {:count => 0, :context => {}}, "purple" => {:count => 0, :context => {}}, "red" => {:count => 0, :context => {}}, "white" => {:count => 0, :context => {}}, "yellow" => {:count => 0, :context => {}}, 'violet' => {:count => 0, :context => {}}, 'indigo' => {:count => 0, :context => {}}}
	end

	def get_results()
		return super("Colours\n=======")
	end
end
