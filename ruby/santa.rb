class Santa

	def speak
		puts "Ho, ho, ho!  Haaaaaaapy Holidays!"
	end

	def eat_milk_and_cookies(cookie)
		puts "That was a good #{cookie}!"
	end

	def initialize(gender, ethnicity)
		puts "Initalizing Santa instance ..."
		@gender = gender
		@ethnicity = ethnicity
		@age = 0
		@reindeer_ranking = ["Rudolph", "Dasher", "Dancer", "Prancer", "Vixen", "Comet", "Cupid", "Donner", "Blitzen"]
	end

end

primeSanta = Santa.new("Male", "Caucasian")
primeSanta.speak
primeSanta.eat_milk_and_cookies("chocolate chip cookie")

santa2 = Santa.new("Female", "Hispanic")
santa3 = Santa.new("In Transition", "Klingon")
