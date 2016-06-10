#Method to create a list
#input: string of items separated by spaces (example: "carrots apples cereal pizza")
#steps
	#Split string by space to turn it into an array
	#create hash/container for items and quantity 
	#create a loop to go through each item
		#push each item into a hash and set default quantity for the items:1
	#create a loop to go through the hash
		#print the list to the console with puts 
	#output: hash

#Method to add an item to a list
#input: item name and optional quantity
#steps:
	#input item name in the hash set it equal to a quantity
#output: print out the shoppling list hash 

#Method to remove an iteam from the list
#input: item name
#steps: input the item name onto hash and delete that item
#output: print out updated shopping list

#Method to update the quantity of an item
#input: item name and new quantity
#steps: input item name into hash and set equal to a new quantity
#output: print out the updated shopping list 

#Method to print a list and make it look pretty 
#input: shopping list hash 
#steps: 
#print out a fancy title for shopping list 
#create a loop to print out each item
	#print the item name right justified: quantity 
#print line to denote the end of a shopping list
#output: the printed list 

def create_list(items)
	grocery_list = {}
	list_of_items = items.split(' ')

	list_of_items.each { |item| grocery_list[item] = 1}
	grocery_list.each {|item, quantity| puts item, quantity}
end

def add_item(grocery_list, item, op_quantity=1)
	if grocery_list[item]
		grocery_list[item] += op_quantity
	else
		grocery_list[item] = op_quantity
	end
	puts grocery_list
	return grocery_list
end 

def remove_item(grocery_list, item)
	grocery_list.delete(item)
	puts grocery_list
end

def update_item(grocery_list, item, quantity)
	grocery_list[item] = quantity
	puts grocery_list
end

def print_list(grocery_list)
	puts "************ GROCERIES ************"
	grocery_list.each do |key, value|
		puts "#{key.ljust(30)} #{value}"
	end
	puts "***********************************"
end

groceries = create_list("lettuce checken honey cheese")
groceries = add_item(groceries, "Lemonade", 2)
add_item(groceries, "Tomatoes", 3)
add_item(groceries, "Onions", 1)
add_item(groceries, "Ice cream", 4)
add_item(groceries, "melon")
remove_item(groceries, "Onions")
update_item(groceries, "Lemonade", 100)
add_item(groceries, "Lemonade", 40)
print_list(groceries)