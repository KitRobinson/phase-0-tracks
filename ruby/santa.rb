class Santa

	def speak
		puts "Ho, ho, ho!  Haaaaaaapy Holidays!"
	end

	def eat_milk_and_cookies(cookie)
		puts "That was a good #{cookie}!"
	end

	def initialize
		puts "Initalizing Santa instance ..."
	end

end

primeSanta = Santa.new
primeSanta.speak
primeSanta.eat_milk_and_cookies("chocolate chip cookie")
