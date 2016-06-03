restaurant = {
	smoking_section: {
		table_1: {
			seats: 6,
			server: "Adam",
			guests: ["Gideon, Jace, Chandra"]
		},
		table_2: {
			seats: 4,
			server: "Adam",
			guests: ["Paula", "Cathy", "Richard", "Lindsay"]
		},
		table_3: {
			seats: 4,
			server: "Bruce",
			guests: []
		}
	},
	nonsmoking_section: {
		table_4: {
			seats: 6,
			server: "Bruce",
			guests: ["James", "Charles", "Charlie", "Jim"]
		},
		table_5: {
			seats: 4,
			server: "Bruce",
			guests: ["Julius", "Octavian", "Nero", "Augustus"]
		},
		table_6: {
			seats: 8,
			server: "Adam",
			guests: ["James", "Leonard", "Hikaru", "Pavel", "Montomery", "Nyota", "Spock"]
		}
	},
	bar_section: {
		seats: 5,
		server: "Charlene",
		guests: ["Jack", "Jim", "James", "Johnny"]
	}
}
puts "Restaurant Initialized!"
puts "Example table 6:"
puts "    Server:"
puts restaurant[:nonsmoking_section][:table_6][:server]
puts "    Guests:"
puts restaurant[:nonsmoking_section][:table_6][:guests][0..-1]
puts "    Seating used at table_6:"
puts "#{restaurant[:nonsmoking_section][:table_6][:guests].length} out of #{restaurant[:nonsmoking_section][:table_6][:seats]}"
puts ""
puts "    Total count of guests at restaurant:"
guestcount = 0
restaurant.each do |key, value|
	if value.is_a?(Array)
		guestcount += value.length
	end
	if value.is_a?(Hash)
		value.each do |key2, value2|
			if value2.is_a?(Array)
				guestcount += value2.length
			end
			if value2.is_a?(Hash)
				value2.each do |key3, value3|
					if value3.is_a?(Array)
						guestcount += value3.length
					end
				end
			end
		end
	end
end
puts guestcount