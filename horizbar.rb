# This is a slightly modified version of the HorizBar script taken from
# https://blogs.oracle.com/realneel/entry/ascii_graphs_using_ruby

class HorizBar
	WIDTH = 72
	HEIGHT = 16
	attr :output_file, true

	def initialize(array)
		@values = array
		@output_file = STDOUT
	end

	def draw
		#Adjust X axis when there are more than WIDTH cols
		if @values.length > WIDTH then
			old_values = @values;
			@values = []
			0.upto(WIDTH - 1){ |i| @values << old_values[i*old_values.length/WIDTH]}
		end

		max = 0
		@values.each do |val|
			if !val.nil? and max < val
				max = val
			end
		end
		# can't use this as the array can have nil's in it
		# and max can't cope with that
		# max = @values.max
		if max == 0
			return
		end

		# initialize display with blanks
		display = Array.new(HEIGHT).collect { Array.new(WIDTH, ' ') }
		@values.each_with_index do |e, i|
			f = (e.nil?)?0:e

			num= f*HEIGHT/max
			(HEIGHT - 1).downto(HEIGHT - 1 - num){|j| display[j][i] = '|'}
		end    
		display.each{|ar| ar.each{|e| @output_file.putc e}; @output_file.puts "\n"} #now print

		no_of_digits = (@values.length - 1).to_s.length
		0.upto(no_of_digits) do |digit_number|
			0.upto(@values.length - 1) do |x|
				@output_file.print sprintf("%0#{no_of_digits}d", x)[digit_number]
			end
			@output_file.puts
		end
	end
end
