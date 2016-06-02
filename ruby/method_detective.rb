# Replace in the "<???>" with the appropriate method (and arguments, if any).
# Uncomment the calls to catch these methods red-handed.

# When there's more than one suspect who could have
# committed the crime, add additional calls to prove it.

puts "iNvEsTiGaTiOn".swapcase
# => “InVeStIgAtIoN”

puts "zom".sub('o','oo')
# => “zoom”

puts "enhance".center(15, padstr=' ')
# => "    enhance    "

puts "Stop! You’re under arrest!".upcase
# => "STOP! YOU’RE UNDER ARREST!"

puts "the usual".concat(" suspects")
puts "the usual".ljust(18, "suspects")
#=> "the usual suspects"

puts " suspects".rjust(18, "the usual")
puts " suspects".prepend("the usual")
# => "the usual suspects"

puts "The case of the disappearing last letter"[0...-1]
puts "The case of the disappearing last letter".chomp('r')
puts "The case of the disappearing last letter".chop
puts "The case of the disappearing last letter".slice(0...-1)
# => "The case of the disappearing last lette"

puts "The mystery of the missing first letter".slice(1...100000000)
puts "The mystery of the missing first letter".sub(/./,"")
# => "he mystery of the missing first letter"

puts "Elementary,    my   dear        Watson!".split.join(" ")
puts "Elementary,    my   dear        Watson!".squeeze
# => "Elementary, my dear Watson!"

puts "z".getbyte(1)
puts "122 is the bytecode for 'z' - if we were writing in ASCII.  Ruby now appears to use Unicode instead, so this is a matter of back-compatibility"
# => 122 
# (What is the significance of the number 122 in relation to the character z?)
# 122 is the

puts "How many times does the letter 'a' appear in this string?".count('a')
# => 4