#Variables
name = nil
age = nil
birthYear = nil
wantsGarlicBread = nil
wantsHealthInsurance = nil
results = nil

#Start
puts "Welcome to the automated Werewolves Inc. HR system!"
puts "How many employees will we process today?"
employees = gets.chomp.to_i
empdone = 1
while employees > 0
puts "You are employee #{empdone} out of #{empdone+employees-1}."
puts "Please answer the following questions:"
puts "What is your name?"
name = gets.chomp
puts "Thanks #{name}, now what is your age?"
age = gets.chomp.to_i
puts "Excellent... and what year were you born?"
birthYear = gets.chomp.to_i
puts "Great work.  Incidentally, our company cafeteria has garlic bread today, should we order some for you? (Y/N)"
if gets.chomp == 'Y'
	wantsGarlicBread = true
else
	wantsGarlicBread = false
end
puts "Ok.  And speaking of things you might want, would you like to enroll in the company's health insurance? (Y/N)"
if gets.chomp == 'Y'
	wantsHealthInsurance = true
else
	wantsHealthInsurance = false
end
allergy = "allergy"
puts "Please enter any allergies one at a time - type done when finished"
until (allergy.downcase == "done" || allergy.downcase == "sunlight")
		allergy = gets.chomp
end
puts "Thank you for filling out the employee data sheet!"
results = "inconclusive"
if 2016-age == birthYear && (wantsHealthInsurance || wantsGarlicBread)
	results = "Probably not a vampire."
end
if 2016-age != birthYear && (!wantsHealthInsurance || !wantsGarlicBread)
	results = "Probably a vampire."
end
if 2016-age != birthYear && (!wantsGarlicBread && !wantsHealthInsurance)
	results = "Almost certainly a vampire."
end
if (name.downcase == "drake cula" || name.downcase == "tu fang")
	results = "Definitely a vampire"
end
if (allergy.downcase == "sunlight")
	results = "Probably a vampire."
end	
puts results
employees = employees - 1
empdone = empdone + 1
end
puts "Actually, never mind! What do these questions have to do with anything? Let's all be friends."