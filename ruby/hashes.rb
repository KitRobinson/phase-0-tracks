#pseudocoded vesion:
# create an empty hash to fill with data
# use a puts to create query, and a gets to aquire data
# validate data, convert to proper type, requery if necessary
# add to hash
# repeat the query, validate, add - as many times as seems necessary
# print out hash (one line at a time by looping)
# offer chance to update a key by typing in the name!
#    - convert gets input to symbol
#    - check if symbol exists in the hash
# 		update data if possible.
# reprint the hash.

# app start here
puts "Welcome to ClientID - the CRM where ID is for interior design!"
# create an empty hash to fill with data
client_data = {}
puts "Enter new Client..."
# use a puts to create query, and a gets to aquire data
puts "Client Name:"
name = gets.chomp
# validate data, convert to proper type, requery if necessary
while name == ""
	puts "Please enter a name!"
	name = gets.chomp
end
# add to hash
client_data[:name] = name
# repeat the query, validate, add - as many times as seems necessary
puts "#{name}'s Age:"
age = gets.chomp.to_i
while age <= 0
	puts "please enter a positive integer!"
	age = gets.chomp.to_i
end
client_data[:age] = age
puts "Is #{name} married?  (y/n)"
married_string = gets.chomp
married_bool = nil
while married_bool == nil
	if married_string.downcase == "y"
		married_bool = true
		client_data[:married] = married_bool
	else
		if married_string.downcase == "n"
			married_bool = false
			client_data[:married] = married_bool
		else
			puts "this is a yes or no question (y/n) - I know it can be complicated, but choose the answer you feel best fits the situation!"
			married_string = gets.chomp
		end
	end
end
puts "#{name}'s dwelling type?"
housing = gets.chomp
while housing == ""
	puts "Please enter a dwelling type!"
	housing = gets.chomp
end
client_data[:housing] = housing
puts "#{name}'s desired style:"
style = gets.chomp
while name == ""
	puts "Please enter a style!"
	style = gets.chomp
end
client_data[:style] = style
# print out hash (one line at a time by looping)
puts "Great!  Let's review:"
puts "Name:      #{client_data[:name]}"
puts "Age:       #{client_data[:age]}"
puts "Married:   #{client_data[:married]}"
puts "Housing:   #{client_data[:housing]}"
puts "Style:     #{client_data[:style]}"
# offer chance to update a key by typing in the name!
#    - convert gets input to symbol
#    - check if symbol exists in the hash
# 		update data if possible.
# reprint the hash.