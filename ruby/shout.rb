=begin
module Shout

	def self.yell_angrily(words)
    	words + "!!!" + " :("
  	end

  	def self.yelling_happily(words)
    	words + "!!!" + " :)"
  	end

end



puts Shout.yelling_happily("Hello")
puts Shout.yell_angrily("Go Away")
=end

module Shout

	def yell_angrily(words)
		puts words + "!!! :("
	end

	def yell_happily(words)
		puts words.upcase + "!!! :)"
	end
end

class Neighbor 
	include Shout
end

class Castaway
	include Shout
end

neighbor = Neighbor.new
neighbor.yell_happily("I love your yard art")
neighbor.yell_angrily("but get if off my lawn")

castaway = Castaway.new
castaway.yell_angrily("I am trapped on this island")
castaway.yell_happily("look, a ship!  I'm saved")
castaway.yell_angrily("NoOOooOoOO it's sailing away")

