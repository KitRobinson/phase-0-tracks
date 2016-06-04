#psuedocode:

#create an array of vowels and consonants for reference
$vowels = ['a','e','i','o','u','a']
$consonants = ["b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z","b"]
#create a hash to store names and codenames
$codenameDatabase = {}
#create an encrypt method.  I was originally going to make one for vowels and consonants, but its easy enough to have in 1 method, and I think it its still doing one task - encrypting a single letter!
def encrypt (myLetter)
	$vowels.each do |vowel|
		#check to see if the letter appears in the vowels array
		if vowel == myLetter
			#if so, return the next vowel in the array (we added "a" at the end of vowels, since the index method will return the FIRST match)
			return $vowels[$vowels.index(vowel)+1]
		end
	end
	$consonants.each do |consonant|
		#check to see if the letter appears in the consonants array
		if consonant == myLetter
			#when found, return the next consonant in the array
			return $consonants[$consonants.index(consonant)+1]
		end
	end
end 

#get a user inputted string as a name
def addNameToEncrypt
	puts "enter a name to encrypt!"
	input = gets.chomp
#recognize a quit command from the user
	if input != "quit"	
#downcase the inputted string to remove caps
		input.downcase!
#break it into a first and last name (a string array)... is it a problem if there are more than 2 names?  no, we are just going to reverse the array
		nameArray = input.split()
	#reverses the array
		nameArray.reverse!
	#for each word in the array
		nameArray.each do |name|
		#break the word into letters
			letterArray = name.chars
		#for each letter in the array of letters
			letterArray.each do |letter|
			#run the encrypting method on each letter
				encryptedletter = encrypt(letter)
				letterArray[letterArray.index(letter)] = encryptedletter
			end
		#reassemble the new letters into a word
			encryptedName = letterArray.join("")
		#capitalize the first letter in the word
			encryptedName.capitalize!
			nameArray[nameArray.index(name)] = encryptedName
			end
	#reassemble the words back into a string	
		encryptedName = nameArray.join(" ")
	#add the string to a hash, with the codename as the key, and the realname as value
		$codenameDatabase[encryptedName] = input.capitalize
	#then go through the hash, printing each key value pair
		puts ""
		$codenameDatabase.each do |key, value|
			puts "#{key} is actually #{value}!"
		end
	return true
	else 
		return false
	end
end

moreNames = true
while moreNames
moreNames = addNameToEncrypt
end
puts "thank you for encrypting names!"