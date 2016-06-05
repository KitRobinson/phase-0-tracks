def makeArray(item1, item2, item3)
	newArray = [item1, item2, item3]
	otherNewArray = []
	otherNewArray << item1
	otherNewArray << item2
	otherNewArray << item3
	return newArray
end

def add_to_array(arr, value)
	arr << value
	return arr
end


ourArray = []
p ourArray
ourArray.push("Lion", "Tiger", "Zebra", "Monkey", "Cheetah")
p ourArray
ourArray.delete_at(2)
p ourArray
ourArray.insert(2, "Bear")
p ourArray
ourArray.shift
p ourArray
if ourArray.include? ("Tiger")
	puts "There is a Tiger!"
else 
	puts "No Tiger here!"
end
fishArray = ["Shark", "Sea Bass", "Salmon"]
combinedArray = ourArray + fishArray
p combinedArray

p makeArray("Wine", "Women", "Song")
p add_to_array(["happy", "sad", "sleepy"], "hungry")
p add_to_array(combinedArray, "Stork")