# Class to extend getoptlong to add the ability to add
# an option to an existing list.
#
# Basically the code from set_options with the loop removed
# so it only parses the argument passed and without clearing
# down the structures first.

require "getoptlong"

class PipalGetoptLong < GetoptLong
	def add_option (arg)
		#
		# The method is failed if option processing has already started.
		#
		if @status != STATUS_YET
		  raise RuntimeError,
			"invoke set_options, but option processing has already started"
		end

      if !arg.is_a?(Array)
       raise ArgumentError, "the option list contains non-Array argument"
      end
	  
      #
      # Find an argument flag and it set to `argument_flag'.
      #
      argument_flag = nil
      arg.each do |i|
        if ARGUMENT_FLAGS.include?(i)
          if argument_flag != nil
            raise ArgumentError, "too many argument-flags"
          end
          argument_flag = i
        end
      end

      raise ArgumentError, "no argument-flag" if argument_flag == nil

      canonical_name = nil
      arg.each do |i|
        #
        # Check an option name.
        #
        next if i == argument_flag
        begin
          if !i.is_a?(String) || i !~ /^-([^-]|-.+)$/
            raise ArgumentError, "an invalid option `#{i}'"
          end
          if (@canonical_names.include?(i))
            raise ArgumentError, "option redefined `#{i}'"
          end
        rescue
          @canonical_names.clear
          @argument_flags.clear
          raise
        end

        #
        # Register the option (`i') to the `@canonical_names' and
        # `@canonical_names' Hashes.
        #
        if canonical_name == nil
          canonical_name = i
        end
        @canonical_names[i] = canonical_name
        @argument_flags[i] = argument_flag
      end
      raise ArgumentError, "no option name" if canonical_name == nil


	end
end
