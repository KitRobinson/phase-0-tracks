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
  
end

rover = Puppy.new

rover.fetch("ball")
rover.speak(4)
rover.roll_over
puts rover.dog_years(1)
puts rover.dog_years(2)
puts rover.dog_years(3)
puts rover.dog_years(4)
rover.come