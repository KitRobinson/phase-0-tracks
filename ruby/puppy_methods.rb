class Puppy

  def fetch(toy)
    puts "I brought back the #{toy}!"
    toy
  end

  def speak(barks)
  	barks.to_i.times {puts "Woof"}
  end

  def roll_over()
  	puts "*rolls over*"
  end

  def dog_years(age)
  	if age <= 2
  		return age*10.5
  	end
  	if age > 2
  		return (21 + (age-2)*4)
  	end
  end

  def come()
  	puts "*comes near*"
  end

  def initialize()
  	puts "initializing new puppy instance"
  end

end

class State

	@name = nil
	@capitol = nil
	def initialize(stateName, stateCapitol)
		@name = stateName
		@capitol = stateCapitol
	end

	def visit()
		puts "visited #{@name}"
	end

	def nameCapitol()
		puts "the capitol of #{@name} is #{@capitol}"
	end

end

stateNames = ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"
]
stateCapitols = ["Montgomery","Juneau","Phoenix","Little Rock","Sacramento","Denver","Hartford","Dover","Tallahassee","Atlanta","Honolulu","Boise","Springfield","Indianapolis","Des Moines","Topeka","Frankfort","Baton Rouge","Augusta","Annapolis","Boston","Lansing","St. Paul","Jackson","Jefferson City","Helena","Lincoln","Carson City","Concord","Trenton","Santa Fe","Albany","Raleigh","Bismarck","Columbus","Oklahoma City","Salem","Harrisburg","Providence","Columbia","Pierre","Nashville","Austin","Salt Lake City","Montpelier","Richmond","Olympia","Charleston","Madison","Cheyenne"
]
states = []
for i in 0..49
	states[i] = State.new(stateNames[i], stateCapitols[i])
end

puts "there are #{states.length} states in our list"

states.each do |thisState|
	thisState.visit
	thisState.nameCapitol
end
=begin
puts "init test 1"
rover = Puppy.new
puts "init test 2"
rover.fetch("ball")
rover.speak(4)
rover.roll_over
puts rover.dog_years(1)
puts rover.dog_years(2)
puts rover.dog_years(3)
puts rover.dog_years(4)
rover.come
=end
