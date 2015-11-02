# A description of the file, used in verbose mode
$layout_description = "US keyboard layout"

$layout = {
				"!" => { # The character !
					0 => "1", # is on the same key as 1
					1 => "2\"q" # and is just one key away from 2, " and q
					# 2 => "3wa" + gbp # If you wanted to add keys two characters away you could with this line
				},
				"1" => { 0 => "!", 1 => "2@`~q"},
				"q" => { 1 => "1!2@wa"},
				"a" => { 1 => "qwsxz\\"},
				"z" => { 1 => "asx"},
				"|" => { 0 => "\\", 1 => "]}"},
				"\\" => { 0 => "|", 1 => "az"},
				"2" => { 0 => '@', 1 => "1!qw3#"},
				"@" => { 0 => '2', 1 => "1!qw3#"},
				"w" => { 1 => "2@3#edsaq"},
				"s" => { 1 => "qwedcxza"},
				"x" => { 1 => "zasdc"},
				"3" => { 0 => "#", 1 => "2@wer4$"},
				"#" => { 0 => "3", 1 => "2@wer4$"},
				"e" => { 1 => "w34rfds#\$"},
				"d" => { 1 => "werfvcxs"},
				"c" => { 1 => "xsdfv"},
				"4" => { 0 => "$", 1 => "%3er5"},
				"$" => { 0 => "4", 1 => "%3er5"},
				"r" => { 1 => "4$5%tgfde"},
				"f" => { 1 => "ertgvcd"},
				"v" => { 1 => "cfgb"},
				"5" => { 0 => "%", 1 => "4$rt6^"},
				"%" => { 0 => "%", 5 => "4$rt6^"},
				"t" => { 1 => "5%6^ygr"},
				"g" => { 1 => "vbhfty"},
				"b" => { 1 => "vghn"},
				"6" => { 0 => "^", 1 => "5%ty7&"},
				"^" => { 0 => "6", 1 => "5%ty7&"},
				"y" => { 1 => "67^&uhgt" },
				"h" => { 1 => "yujnbg" },
				"n" => { 1 => "bhjm" },
				"7" => { 0 => "&", 1 => "6^yu8*"},
				"&" => { 0 => "7", 1 => "6^yu8*"},
				"u" => { 1 => "78&*ijhy"},
				"j" => { 1 => "uikmnh"},
				"m" => { 1 => "njk,<"},
				"8" => { 0 => "*", 1 => "7ui9&("},
				"*" => { 0 => "8", 1 => "7ui9&("},
				"i" => { 1 => "89*(okju"},
				"k" => { 1 => "iol,mj"},
				"," => { 0 => "<", 1 => "mkl.>"},
				"9" => { 0 => "(", 1 => "80*)io"},
				"(" => { 0 => "9", 1 => "80*)io"},
				"o" => { 1 => "90()plki"},
				"l" => { 1 => "op;:.>,<k"},
				"." => { 0 => ">", 1 => ",<l;:/?"},
				">" => { 0 => ".", 1 => ",<l;:/?"},
				"0" => { 0 => ")", 1 => "9(op-_"},
				")" => { 0 => "9", 1 => "9(op-_"},
				"p" => { 1 => "0)-_[{;:lo"},
				";" => { 0 => ":", 1 => "p[{'\"/?.>l"},
				":" => { 0 => ";", 1 => "p[{'\"/?.>l"},
				"/" => { 0 => "?", 1 => ".>;:'\""},
				"?" => { 0 => "/", 1 => ".>;:'\""},
				"-" => { 0 => "_", 1 => "0)p[{=+"},
				"_" => { 0 => "-", 1 => "0)p[{=+"},
				"[" => { 0 => "{", 1 => "-_=+]}'\";:p"},
				"{" => { 0 => "[", 1 => "-_=+]}'\";:p"},
				"'" => { 0 => "\"", 1 => "[{]}/?;:"},
				"\"" => { 0 => "'", 1 => "[{]}/?;:"},
				"=" => { 0 => "+", 1 => "-_[{]}"},
				"+" => { 0 => "=", 1 => "-_[{]}"},
				"]" => { 0 => "}", 1 => "=+[{'|\\\""},
				"}" => { 0 => "}", 1 => "=+[{'|\\\""},
				"`" => { 0 => "~", 1 => "1!"},
				"~" => { 0 => "`", 1 => "1!"},
			}

# This is the furthest distance we are looking for as a jump + 1
# This could be calculated by the app when it starts up but that 
# seems like unnecessary work as you already know it when creating
# this file.
#
# You could also chose to penalise keys further away more by giving
# them a higher score.
MAX_SCORE = 2
