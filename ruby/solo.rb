=begin

Employee Class -----------------

Properties of employees:--------
first name
last name
title
phone number
email address
rate of pay
supervisor
direct reports []
employee ID
wages owed

methods of employees------------ 
update info (covered in part by accessor methods)
work
collect pay
assign to supervisor

=end
$nextID = 1
$employeeDirectory = []


class Employee

	attr_reader :employeeID, :directReports, :wages
	attr_accessor :supervisor, :first, :last, :eMail, :phone, :pay, :title

	def initialize(first, last)
		@first = first
		@last = last
		@title = "worker"
		@employeeID = $nextID
		$nextID = $nextID+1
		@phone = "312-123-" + (@employeeID.to_s).rjust(4,'0')
		@eMail = first[0] + last + "@company.com"
		@supervisor = nil
		@directReports = []
		@pay = 10
		@wages = 0
		$employeeDirectory << self
	end

	def enumerate
		if @supervisor == nil
			puts "#{@employeeID.to_s.ljust(3)} #{(@last + ",").ljust(12)} #{@first.ljust(12)} #{@title.ljust(18)} #{eMail.ljust(25)} *****"
		else
			puts "#{@employeeID.to_s.ljust(3)} #{(@last + ",").ljust(12)} #{@first.ljust(12)} #{@title.ljust(18)} #{eMail.ljust(25)} #{(@supervisor.first + " " + @supervisor.last).ljust(22)}"
		end
	end

	def about
		puts "*********"
		puts @last + ", " + @first
		if @supervisor != nil
			puts @title + ", reporting to " + @supervisor.first + " " + @supervisor.last
 		else
			puts @title
		end
		puts "phone: " + @phone + ", email: " + @eMail
		puts "pay rate: $" + @pay.to_s
		puts "currently owed: $" + @wages.to_s + " in wages"  
		puts "*********"
	end

	def work(hours)
		puts @first + " works for " + hours.to_s + " hours"
		@wages = @wages + (hours * @pay)
		puts "and is now owed $" + @wages.to_s
	end

	def collectPay
		puts @first + " collects $" + @wages.to_s + " in wages."
		@wages = 0
	end 

	def assignSupervisor(supervisor)
		$employeeDirectory.each do |person|
			if person.first == supervisor || person.first + " " + person.last == supervisor
				@supervisor = person
			end
		end

		if @supervisor != nil 
			if @supervisor.first == supervisor || @supervisor.first + " "  + @supervisor.last == supervisor
				puts "#{@first} now reports to #{@supervisor.first} #{@supervisor.last}"
			end
		else
			puts "could not find #{supervisor} in list of employees"
		end
	end
end


# ***********************************************
# *****METHODS FOR USER INTERFACE START HERE*****
# ***********************************************
def listEmp
	#uses enumerate method of Employee to create a formatted list of employees
	puts "#{"ID".ljust(3)} #{"Last Name".ljust(12)} #{"First Name".ljust(12)} #{"Title".ljust(18)} #{"E-Mail".ljust(25)} Supervisor"
	puts "".ljust(80,"-")
	$employeeDirectory.each {|x| x.enumerate}
end

def addEmp
	puts "Enter new employee first name"
	fname = gets.chomp
	puts "Enter new employee last name"
	lname = gets.chomp
	currentAdd = Employee.new(fname.strip,lname.strip)
	puts "#{fname} #{lname} has been added."
	puts "the default job title is 'worker' - press enter for OK, or type in a new title for #{fname}"
	titlechange = gets.chomp
	if titlechange != ""
		currentAdd.title = titlechange
	end
	puts "the default rate of pay is $10 per hour - press enter for OK, or type a new rate of pay"
	paychange = gets.chomp
	if paychange != ""
		currentAdd.pay = paychange.sub("$","").to_i
	end
	puts "would you like to assign #{fname} to report to another employee already in the directory?"
	puts "simply hit enter to skip, or type an employees name to assign them as #{fname}'s supervisor."
	supervisorchange = gets.chomp
	if supervisorchange != ""
		currentAdd.assignSupervisor(supervisorchange)
	end
end

def viewEmp
	#locates an employee in the directory and prints out their info
	puts "Enter the first and last name, or the employee's ID number"
	findString = gets.chomp.strip
	if findString.to_i != 0
		# if to_i give a number, they are searching by employee ID
		$employeeDirectory.each do |person|
			if person.employeeID == findString.to_i
				person.about
			end
		end
	elsif
		# if not by number, get the first name (and last if entered)
		names = findString.split(" ")
		fname = names[0]
		lname = ""
		if names.length > 1
			lname = names[1]
		end
		$employeeDirectory.each do |person|
			if person.first == fname || person.last == lname
				# rather than testing to see if the last name matches, right now we will simply print out all employees with the same first name
				person.about
			end
		end
	else 
		puts "employee not found"
	end
end

def assign
	#assigns the chosen employee to work under a new supervisor
	puts "Enter the first and last name, or the employee's ID number, for the employee to be assigned to a new supervisor"
	findString = gets.chomp.strip
	puts "Enter the first and last name, or the employee ID number, for the new supervisor of emploee #{findString}"
	findString2 = gets.chomp.strip
	subordinate = nil
	superordinate = nil
	if findString.to_i != 0
		# if to_i give a number, they are searching by employee ID
		$employeeDirectory.each do |person|
			if person.employeeID == findString.to_i
				subordinate = person
			end
		end
	elsif
		# if not by number, get the first name (and last if entered)
		names = findString.split(" ")
		fname = names[0]
		lname = ""
		if names.length > 1
			lname = names[1]
		end
		$employeeDirectory.each do |person|
			if person.first == fname || person.last == lname
				# rather than testing to see if the last name matches, right now we will simply print out all employees with the same first name
				subordinate = person
			end
		end
	else 
		puts "employee not found"
	end
	# now the same process is used to find the proposed supervisor
	if findString2.to_i != 0
		# if to_i give a number, they are searching by employee ID
		$employeeDirectory.each do |person|
			if person.employeeID == findString2.to_i
				superordinate = person
			end
		end
	elsif
		# if not by number, get the first name (and last if entered)
		names = findString2.split(" ")
		fname = names[0]
		lname = ""
		if names.length > 1
			lname = names[1]
		end
		$employeeDirectory.each do |person|
			if person.first == fname || person.last == lname
				# rather than testing to see if the last name matches, right now we will simply print out all employees with the same first name
				superordinate = person
			end
		end
	else 
		puts "supervisor not found"
	end
	if subordinate != nil and superordinate != nil
		subordinate.assignSupervisor(superordinate.first)
	else
		puts "unable to complete assignment"
	end
end

def addHours
	# MARKS THE EMPLOYEE AS HAVING WORKED SOME HOURS
	puts "Enter the first and last name, or the employee's ID number, for the employee to be credited with hours worked"
	findString = gets.chomp.strip
	puts "Enter the numbere of hours worked"
	hours = gets.chomp.to_i
	if findString.to_i != 0
		# if to_i give a number, they are searching by employee ID
		$employeeDirectory.each do |person|
			if person.employeeID == findString.to_i
				person.work(hours)
			end
		end
	elsif
		# if not by number, get the first name (and last if entered)
		names = findString.split(" ")
		fname = names[0]
		lname = ""
		if names.length > 1
			lname = names[1]
		end
		$employeeDirectory.each do |person|
			if person.first == fname || person.last == lname
				# rather than testing to see if the last name matches, right now we will simply print out all employees with the same first name
				person.work(hours)
			end
		end
	else 
		puts "employee not found"
	end
end 

def writeCheck
	# PAY DESIGNATED EMPLOYEE(S) 
	puts "Enter the first and last name, or ID number, for the employee to be paid - or 'ALL' to write all payckecks."
	findString = gets.chomp.strip
	if findString.downcase == "all"
		$employeeDirectory.each do |person|
			if person.wages != 0
				person.collectPay
			end
		end
	elsif findString.to_i != 0
		# if to_i give a number, they are searching by employee ID
		$employeeDirectory.each do |person|
			if person.employeeID == findString.to_i
				person.collectPay
			end
		end
	elsif
		# if not by number, get the first name (and last if entered)
		names = findString.split(" ")
		fname = names[0]
		lname = ""
		if names.length > 1
			lname = names[1]
		end
		$employeeDirectory.each do |person|
			if person.first == fname || person.last == lname
				# rather than testing to see if the last name matches, right now we will simply print out all employees with the same first name
				person.collectPay
			end
		end
	else 
		puts "employee not found"
	end
end

#        **********************************************
#             *** DEMONSTRATION INFO STARTS HERE ***
#        **********************************************

def loadDemoCompany
	$employeeDirectory.clear
	emperor = Employee.new("Emperor","Palpatine")
	emperor.title = "Emperor"
	emperor.pay = 10000
	vader = Employee.new("Darth","Vader")
	vader.title = "Sith Lord"
	vader.pay = 3000
	vader.assignSupervisor("Emperor Palpatine")
	moff = Employee.new("Gilad", "Tarkin")
	moff.title = "Grand Moff"
	moff.pay = 2990
	moff.assignSupervisor("Emperor Palpatine")
	tk4 = Employee.new("Lieutenant", "427")
	tk4.title = "Stormtrooper Lt."
	tk4.pay = 25
	tk4.assignSupervisor("Darth Vader")
	for i in 0...10
		Employee.new("Trooper", rand(999).to_s)
		$employeeDirectory[i+4].title = "Stormtrooper"
		$employeeDirectory[i+4].assignSupervisor("Lieutenant 427")
	end
end

#        **********************************************
#              ***** USER INTERFACE STARTS HERE *****
#        **********************************************

puts "Welcome to the employee directory"
puts "the special 'LOAD' command is available for demonstration purposes"
userCommand = ""
while userCommand.downcase != "exit"
	puts "there are currently #{$employeeDirectory.length} employees"
	puts "would you like to 'LIST' 'ADD EMPLOYEE' 'ADD HOURS' 'ASSIGN SUPERVISOR', 'VIEW EMPLOYEE', 'WRITE PAYCHECK' or 'EXIT'?"
	userCommand = gets.chomp
	while userCommand.downcase != "load" && userCommand.downcase != "list" && userCommand.downcase != "add employee" && userCommand.downcase != "add hours" && userCommand.downcase != "assign supervisor" && userCommand.downcase != "view employee" && userCommand.downcase != 'help' && userCommand.downcase != "exit" && userCommand.downcase != "write paycheck"
		puts "I did not understand your command - try again or type 'HELP' for assistance"
		userCommand = gets.chomp
	end
	if userCommand.downcase == "load"
		loadDemoCompany
	end
	if userCommand.downcase == "list"
		listEmp
	end
	if userCommand.downcase == "add employee"
		addEmp
	end
	if userCommand.downcase == "view employee"
		viewEmp
	end
	if userCommand.downcase == "assign supervisor"
		assign
	end
	if userCommand.downcase == "add hours"
		addHours
	end
	if userCommand.downcase == "write paycheck"
		writeCheck
	end
end	
