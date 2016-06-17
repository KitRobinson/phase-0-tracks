# Virus Predictor

# I worked on this challenge [by myself, with: ].
# We spent [#] hours on this challenge.

# EXPLANATION OF require_relative
#
#
require_relative 'state_data'

class VirusPredictor


  def initialize(state_of_origin, population_density, population)
    @state = state_of_origin
    @population = population
    @population_density = population_density
  end

  def virus_effects
    predicted_deaths
    speed_of_spread
  end

  private

  def predicted_deaths
    # predicted deaths is solely based on population density
      
    if @population_density >= 200
      x = 0.4
    elsif @population_density >= 150
      x = 0.3
    elsif @population_density >= 100
      x = 0.2
    elsif @population_density >= 50
      x = 0.1
    else
      x = 0.05
    end
      number_of_deaths = (@population * x).floor

    print "#{@state} will lose #{number_of_deaths} people in this outbreak"

  end

  def speed_of_spread #in months
    # We are still perfecting our formula here. The speed is also affected
    # by additional factors we haven't added into this functionality.

    if @population_density >= 200
      speed = 0.5
    elsif @population_density >= 150
      speed = 1
    elsif @population_density >= 100
      speed = 1.5
    elsif @population_density >= 50
      speed = 2
    else
      speed = 2.5
    end

    puts " and will spread across the state in #{speed} months.\n\n"

  end

end

#=======================================================================

# DRIVER CODE
 # initialize VirusPredictor for each state


alabama = VirusPredictor.new("Alabama", STATE_DATA["Alabama"][:population_density], STATE_DATA["Alabama"][:population])
alabama.virus_effects

jersey = VirusPredictor.new("New Jersey", STATE_DATA["New Jersey"][:population_density], STATE_DATA["New Jersey"][:population])
jersey.virus_effects

california = VirusPredictor.new("California", STATE_DATA["California"][:population_density], STATE_DATA["California"][:population])
california.virus_effects

alaska = VirusPredictor.new("Alaska", STATE_DATA["Alaska"][:population_density], STATE_DATA["Alaska"][:population])
alaska.virus_effects

STATE_DATA.each do |state, info|
  tester = VirusPredictor.new(state, info[:population_density], info[:population])
#  tester = VirusPredictor.new(state, STATE_DATA[state][:population_density], STATE_DATA[state][:population])
  tester.virus_effects
end

#=======================================================================
# Reflection Section

#the 2 different hash syntaxes are using Strings or Symbols for the hashes.  We use a String when we expect that value to change (such as a states name), and we can use a symbol when we are using it as more of a label for the data, and less like a piece of data  itself (:population)
#Require relative does the same thing as require, except that it is speficying that the relative path (i.e. the directory where this .rb file is found) is where to find the resource requried
#we can iterate through hashes with for or while loops and and index number, but it generally seems fastest to do it with .each, which allows us to draw 2 fields |key, value| - if we didn't want both, why bother making a hash?
#the variables were all instance variables with an @, so there was no need to pass in arguments to the method.
#when and how best to pass data like variables (or whole hashes!) between methods, classes, even files - and sometimes when it's easier not to!
