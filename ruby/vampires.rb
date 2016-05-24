#Variables
name = nil
age = nil
birthYear = nil
wantsGarlicBread = nil
wantsHealthInsurance = nil
results = nil

#Start
puts "Welcome to the automated Werewolves Inc. HR system!"
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
if (name == "Drake Cula" || name == "Tu Fang")
	results = "Definitely a vampire"
end
puts results
