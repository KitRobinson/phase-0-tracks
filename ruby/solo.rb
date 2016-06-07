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
update info
work
collect pay
assign to supervisor

=end
$nextID = 1

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
	end

	def about
		puts @last + ", " + @first
		if @supervisor != nil
			puts @title + ", reporting to " + @supervisor
		else
			puts @title
		end
		puts "phone: " + @phone + ", email: " + @eMail
		puts "pay rate: $" + @pay.to_s
		puts "currently owed: $" + @wages.to_s + " in wages"  
	end

end

jack = Employee.new("Jack", "Fisher")
jill = Employee.new("Jill", "Harrison")
peter = Employee.new("Peter", "Hofstader")
jack.about
jill.about
peter.about