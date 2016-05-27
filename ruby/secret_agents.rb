=begin
Psuedocode:

take a message from the spy
for each letter in the message
	if it is a space leave it alone
	if it is a z make it an a
	and if it is an a-y, make it the next letter
then print out the encoded message

or to decrypt
take a coded message from the spy
for each letter in the message,
	if it is a space leave it alone
	if it is an a make it a z (going backwards!)
	and if it is a b-z
		look up that letter in the alphabet (find its number)
		replace it with the previous letter in the alphabet(its number -1)
then print out the decoded message		
	
=end

def encrypt(message)
	for i in 0..(message.length-1)
		if message[i] != " "
			if message[i] == "z"
				message[i] = "a"
			else
				message[i] = message[i].next
			end
		end
	end
	return message
end

def decrypt(message)
	alphabet = "abcdefghijklmnopqrstuvwxyz"
	for i in 0..(message.length-1)
		if message[i] != " "
			if message[i] == "a"
				message[i] = "z"
			else
				message[i] = alphabet[alphabet.index(message[i])-1]
			end
		end
	end
	return message
end

=begin
 
 psuedocode for UI

 get a message from the spy
 	if it is 'swordfish', do the encode/decode from before
 if it is not swordfish,
 	as the spy if they would like to encode or decode
 	if their response is no good
 		ask again until it is!
 	if they asked for encode, run the encode method on their message
 		and print out the encoded message
 	if they asked for decode, run the decoder on their message
 		and print out the decoded message
	
=end

puts "type your message:"
user_message = gets.chomp
if user_message == "swordfish"
	puts "password accepted!"
	puts "encrypt:"
	puts encrypt(user_message)
	puts "encrypt/decrypt:"
	puts decrypt(encrypt("swordfish"))
else
	puts "would you like to encrypt, or decrypt? [e/d]"
	choice = gets.chomp
	while choice != "e" && choice != "d"
		puts "only 'e' for encrypt or 'd' for decrypt are allowed here!"
		choice = gets.chomp
	end
	if choice == "e"
		puts encrypt(user_message)
	else
		puts decrypt(user_message)
	end
end