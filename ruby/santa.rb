class Santa

	attr_reader :reindeer_ranking
	attr_accessor :ethnicity, :gender, :age

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

	def celebrate_birthday
		@age += 1
	end

	def get_mad_at(reindeer)
		if @reindeer_ranking.index(reindeer) != nil
			@reindeer_ranking.delete_at(@reindeer_ranking.index(reindeer))
			@reindeer_ranking << reindeer
		end
	end

	def about
		puts "this Santa is a #{@gender} #{@ethnicity}, and is #{age} years old."
	end
end

example_genders = ["agender", "female", "bigender", "male", "female", "gender fluid", "N/A"]
example_ethnicities = ["black", "Latino", "white", "Japanese-African", "prefer not to say", "Mystical Creature (unicorn)", "N/A"]

=begin
primeSanta = Santa.new("Male", "Caucasian")
primeSanta.speak
primeSanta.eat_milk_and_cookies("chocolate chip cookie")

santa2 = Santa.new("Female", "Hispanic")
santa3 = Santa.new("In Transition", "Klingon")

puts primeSanta.age
primeSanta.celebrate_birthday
puts primeSanta.age
puts primeSanta.reindeer_ranking
primeSanta.get_mad_at("Rudolph")
puts primeSanta.reindeer_ranking
=end

santas = []
for i in 0..999
	santas << Santa.new(example_genders.sample, example_ethnicities.sample)
	santas[i].age = rand(140)
	santas[i].about
end

