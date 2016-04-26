register_checker("US_Zip_Code_Checker")

class US_Zip_Code_Checker < Checker
	# Place your google API key here
	# For more info on getting a key see here
	# https://developers.google.com/maps/documentation/javascript/tutorial#api_key
	# 
	# If you want to leave this blank and pass the key on the command line you can use the --gkey option
	# From experiments it looks like you don't actually need a valid key but better to have one just in case
	API_KEY=''

	def initialize
		super
		@description = "List of US zip codes"
		@zip_codes = {}
	end

	def lookup_by_zipcode(zip)
		geocoder = "http://maps.google.com/maps/geo?q="
		apikey = "&key=" + API_KEY

		# Since the zipcode goes directly into the URL request it needs to be cleaned up.
		request = "#{geocoder}#{URI::encode(zip.to_s)}, USA#{apikey}"
		resp = Net::HTTP.get_response(URI.parse(request))

		data = JSON.parse(resp.body)

		if data.has_key?('Status')
			# puts "status: " + data['Status']['code'].to_s

			if (data.has_key?('Placemark') and data['Placemark'].length > 0)
				#puts data['Placemark'][0].inspect
				# puts "location: " + data['Placemark'][0]['address']

				if data['Placemark'][0].has_key? 'AddressDetails' and
					data['Placemark'][0]['AddressDetails'].has_key? 'Country' and
					data['Placemark'][0]['AddressDetails']['Country'].has_key? 'AdministrativeArea' and
					data['Placemark'][0]['AddressDetails']['Country']['AdministrativeArea'].has_key? 'Locality' and
					data['Placemark'][0]['AddressDetails']['Country']['AdministrativeArea']['Locality'].has_key? 'PostalCode' and
					data['Placemark'][0]['AddressDetails']['Country']['AdministrativeArea']['Locality']['PostalCode'].has_key? 'PostalCodeNumber' and
					data['Placemark'][0]['AddressDetails']['Country'].has_key? 'CountryName'

				#		puts "Location: " + data['Placemark'][0]['AddressDetails']['Country']['CountryName']
				#		puts "Location: " + data['Placemark'][0]['AddressDetails']['Country']['AdministrativeArea']['Locality']['PostalCode']['PostalCodeNumber']
					if data['Placemark'][0]['AddressDetails']['Country']['CountryName'] == 'USA' and data['Placemark'][0]['AddressDetails']['Country']['AdministrativeArea']['Locality']['PostalCode']['PostalCodeNumber'] == zip
						return data['Placemark'][0]['address']
					end
				end

		#		return data['Placemark'][0]['address']
			end
		end

		return nil
	end

	def process_word (word, extras = nil)
		if @API_KEY != ""
			if /([0-9]{5})$/.match(word)
				zip_code = $1.to_i
				if !@zip_codes.has_key?(zip_code)
					@zip_codes[zip_code] = 1
				else
					@zip_codes[zip_code] += 1
				end
			end
		end
		@total_words_processed += 1
	end

	def get_results()
		if API_KEY != ""
			areas = {}
			@zip_codes.each do |zip|
				area = lookup_by_zipcode zip
				unless area.nil?
					areas[zip] = area
				end
			end
			if areas.length > 0
				ret_str = "US Zip Codes\n"
				areas.each_pair do |zip, area|
					ret_str << "#{zip} = #{area}\n"
				end
				ret_str << "\n"
			end
		else
			ret_str = "US Zip Codes\n"
			ret_str << "\nNo Google API key specified\n"
		end

		return ret_str
	end
end
