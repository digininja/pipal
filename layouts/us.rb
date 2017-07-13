
# A description of the file, used in verbose mode
$layout_description = "US keyboard layout"

$layout = {
				"!" => { # The character !
					0 => "1", # is on the same key as 1
					1 => "2`~@q" # and is just one key away from 2, " and q
					# 2 => "3wa" + gbp # If you wanted to add keys two characters away you could with this line
				},
				"1" => { 0 => "!", 1 => "2\"q" },
				"q" => { 1 => "1!2@wa"},
				"a" => { 1 => "qwsz"},
				"z" => { 1 => "asx"},
				"2" => { 0 => "@", 1 => "1!3#qw"},
				"w" => { 1 => "2@qasde3#"},
				"s" => { 1 => "awzxde"},
				"x" => { 1 => "zsdc"},
				"3" => { 0 => "#", 1 => "@$2we4"},
				"e" => { 1 => "#$wsdfr"},
				"d" => { 1 => "ersfxc"},
				"c" => { 1 => "xdfv"},
				"4" => { 0 => "$", 1 => "3#%er"},
				"r" => { 1 => "4$5%etdf"},
				"f" => { 1 => "dcvgtr"},
				"v" => { 1 => "cfgb"},
				"5" => { 0 => "%", 1 => "4rty6"},
				"t" => { 1 => "%5rfgy6"},
				"g" => { 1 => "tfvbhy"},
				"b" => { 1 => "vghn"},
				"6" => { 0 => "^", 1 => "5%ty7&"},
				"y" => { 1 => "^6tghu7&"},
				"h" => { 1 => "ygbnju"},
				"n" => { 1 => "bhjm"},
				"7" => { 0 => "&", 1 => "^6yu*8"},
				"u" => { 1 => "&7yhji*8"},
				"j" => { 1 => "uhnmki"},
				"m" => { 1 => "njk,<"},
				"8" => { 0 => "*", 1 => "7&ui9("},
				"i" => { 1 => "*8ujko(9"},
				"k" => { 1 => "ijm,<lo"},
				"," => { 0 => "<", 1 => "mkl.>"},
				"9" => { 0 => "(", 1 => "*8io0)"},
				"o" => { 1 => "(9iklp0)"},
				"l" => { 1 => "ok,<.>;:p"},
				"." => { 0 => ">", 1 => ",<l;:/?"},
				"0" => { 0 => ")", 1 => "9(op-_"},
				"p" => { 1 => "0)ol;:[{-_"},
				";" => { 0 => ":", 1 => "pl.>/?'\"[{",
				"/" => { 0 => "?", 1 => ".>;:\"'"},
				"-" => { 0 => "_", 1 => "0)p[{=+"},
				"[" => { 0 => "}", 1 => "-_p;:'\"]}=+"},
				"'" => { 0 => "\"", 1 => "]}[{;:/?"},
				"=" => { 0 => "+", 1 => "-_[{]}"},
				"]" => { 0 => "}", 1 => "=+[{'\"\\|"},
				"\\" => { 0 => "|", 1 => "]}"},
				"`" => { 0 => "~", 1 => "1!"},
				"~" => { 0 => "`", 1 => "1!"},
				"@" => { 0 => "2", 1 => "1!qwe3#"},
				"#" => { 0 => "3", 1 => "2@wer4$" },
				"$" => { 0 => "4", 1 => "3#ert5%"},
				"%" => { 0 => "5", 1 => "4$rty^6"},
				"^" => { 0 => "6", 1 => "5%tyu7&"},
				"&" => { 0 => "7", 1 => "6^yui8*"},
				"*" => { 0 => "8", 1 => "7&ui9("},
				"(" => { 0 => "9", 1 => "8*iop0)"},
				")" => { 0 => "0", 1 => "9(op-_"},
				"_" => { 0 => "-", 1 => "0)p[{=+"},
				"+" => { 0 => "=", 1 => "-_[{]}"},
				"{" => { 0 => "[", 1 => "=+-_p;:'\"]}"},
				"}" => { 0 => "]", 1 => "=+[{'\"\\|"},
				"|" => { 0 => "\\", 1 => "]}"},
				":" => { 0 => ";", 1 => "pl.>/?'\"[{"},
				'"' => { 0 => "'", 1 => "]}[{;:/?"},
				"<" => { 0 => ",", 1 => "mkl.>"},
				">" => { 0 => ".", 1 => ",<l;:/?"},
				"?" => { 0 => "/", 1 => ".>;:'\""},
			}
}
# This is the furthest distance we are looking for as a jump + 1
# This could be calculated by the app when it starts up but that 
# seems like unnecessary work as you already know it when creating
# this file.
#
# You could also chose to penalise keys further away more by giving
# them a higher score.
MAX_SCORE = 2
