require_relative "../list_checker.rb"

register_checker("Australia_Checker")

class Australia_Checker < List_Checker
	def initialize
		super
		@description = "List of Australian places "
		@list = {
"adelaide" => 0,
"albany" => 0,
"albury-wodonga" => 0,
"act" => 0,
"ballarat" => 0,
"bathurst" => 0,
"bendigo" => 0,
"bowral-mittagong" => 0,
"brisbane" => 0,
"bunbury" => 0,
"bundaberg" => 0,
"busselton" => 0,
"cairns" => 0,
"canberra" => 0,
"canberra-queanbeyan" => 0,
"coffs" => 0,
"harbour" => 0,
"darwin" => 0,
"devonport" => 0,
"dubbo" => 0,
"geelong" => 0,
"geraldton" => 0,
"gladstone" => 0,
"tannum" => 0,
"goldcoast" => 0,
"gold" => 0,
"coast" => 0,
"tweedheads" => 0,
"herveybay" => 0,
"hervey" => 0,
"hobart" => 0,
"kalgoorlie-boulder" => 0,
"launceston" => 0,
"mackay" => 0,
"melbourne" => 0,
"mildura-wentworth" => 0,
"newcastle" => 0,
"newcastle-maitland" => 0,
"newsouthwales" => 0,
"northernterritory" => 0,
"nowra-bomaderry" => 0,
"orange" => 0,
"perth" => 0,
"portmacquarie" => 0,
"macquarie" => 0,
"queensland" => 0,
"rockhampton" => 0,
"shepparton-mooroopna" => 0,
"sunshinecoast" => 0,
"sunshine" => 0,
"sydney" => 0,
"tamworth" => 0,
"tasmania" => 0,
"toowoomba" => 0,
"townsville" => 0,
"traralgon-morwell" => 0,
"victoria" => 0,
"wagga" => 0,
"warragul-drouin" => 0,
"warrnambool" => 0,
"western" => 0,
"wollongong" => 0,
"new" => 0,
"south" => 0,
"wales" => 0
}

	end

	def get_results()
		return super("Australian Places")
	end
end
