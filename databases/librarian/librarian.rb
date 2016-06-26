#create a librarian program which tracks books in a database,
#and keeps an eye on whether they are checked out or returned



############### BASIC SETUP ####################
#require gems for database creation
require 'sqlite3'

#create SQLite3 database
lib = SQLite3::Database.new("library.db")
lib.results_as_hash = true

#create the authors table
create_author_table = <<-SQL
	CREATE TABLE IF NOT EXISTS authors(
		id INTEGER PRIMARY KEY,
		l_name VARCHAR(255),
		f_name VARCHAR(255)
	)
SQL
#puts create_author_table
lib.execute(create_author_table)

#create books table
create_book_table = <<-SQL
	CREATE TABLE IF NOT EXISTS books(
		id INTEGER PRIMARY KEY,
		title VARCHAR(255),
		author_id INT,
		section VARCHAR(255),
		on_shelf BOOLEAN,
		FOREIGN KEY (author_id) REFERENCES authors(id)
	)
SQL
#puts create_book_table
lib.execute(create_book_table)

# define truncate method for strings to fit into display table
class String
	def truncate(max)
		length > max ? "#{self[0...max-3]}..." : self
	end
end

############### DEFINE BASIC AND SAMPLE METHODS #######################

#adds minimal sized sample data
def sample
	#add 2 test authors
	lib.execute("INSERT INTO authors (l_name, f_name) VALUES ('Robinson', 'Kit')")
	lib.execute("INSERT INTO authors (l_name, f_name) VALUES ('Lancaster', 'Blythe')")
	#add 3 test books
	lib.execute("INSERT INTO books (title, author_id, section, on_shelf) VALUES ('Goodmight Noon', 1, 'Childrens', 'true')")
	lib.execute("INSERT INTO books (title, author_id, section, on_shelf) VALUES ('Leo the Lapp', 1, 'Childrens', 'true')")
	lib.execute("INSERT INTO books (title, author_id, section, on_shelf) VALUES ('The Hermaneutical Bealgeshichte', 2, 'Philosophy', 'true')")
	puts "added the minimal sample:"
	#output the joined list
	joinlist = lib.execute("SELECT * FROM books JOIN authors ON books.author_id = authors.id")
	joinlist.each do |book|
		puts "#{book['title']} by #{book['l_name']} is a #{book['section']} book."
	end
end

#add an imported booklist from a text file
def import(libfile, lib)
	#open the text file containing the booklist from the library
	f = File.open(libfile)
	#parse the incoming lines into arrays of data
	while line = f.gets do
		parsed_line = line.split('*')
		add_book(parsed_line, lib)
	end
	f.close
end


# basic parser for search terms, to read from UI input
def searchby(criteria, value, lib)
	#clear unnecessary apostrophes, and return to int if that was the intention
	value = value.to_s.gsub("'"){"''"}
	#run a sligtly different search if value.class = int...
	if value.to_i == 0	
		#if value is a string, then we add '' around the value
		return lib.execute("Select * from books join authors on books.author_id = authors.id WHERE #{criteria} = '#{value}'")
	else#if value is a string, we pass it in without ''.
		return lib.execute("Select * from books join authors on books.author_id = authors.id WHERE #{criteria} = #{value}")
	end

end

# add an item to the formatted table
def append_to_list(found_list, index_num)
	puts ("#{(found_list[index_num][6]+', '+found_list[index_num][7]).truncate(25).ljust(25, " ")} #{found_list[index_num][1].truncate(40).ljust(40," ")} #{found_list[index_num][3].truncate(15).ljust(15," ")} #{found_list[index_num][0].to_s.truncate(5).ljust(5," ")} #{found_list[index_num][4]}")	
end

# chose a number (num_to_find) of random books in the lib
def browse(num_to_find, lib)
	book_nums = []
	for j in 0...num_to_find
		book_nums.push rand(lib.execute("Select count(title) from books")[0][0])
	end
	found_list = lib.execute("SELECT * FROM books JOIN authors ON books.author_id = authors.id WHERE books.id = #{book_nums[0]}")
	show_books(found_list)
	for k in 1...num_to_find
		found_list = lib.execute("SELECT * FROM books JOIN authors ON books.author_id = authors.id WHERE books.id = #{book_nums[k]}")
		append_to_list(found_list, 0)
	end
end

################### METHODS USED FOR UI ############################

def show_books(found_list)
	puts ""
	puts ""
	puts ("Author                    Title                                    Section        ID     On Shelf")
	puts ("--------------------------------------------------------------------------------------------")
	for i in 0...found_list.size
		puts ("#{(found_list[i][6]+', '+found_list[i][7]).truncate(25).ljust(25, " ")} #{found_list[i][1].truncate(40).ljust(40," ")} #{found_list[i][3].truncate(15).ljust(15," ")} #{found_list[i][0].to_s.truncate(5).ljust(5," ")} #{found_list[i][4]}")
	end
end

# chose a number (num_to_find) of random books in the lib
def browse(num_to_find, lib)
	book_nums = []
	for j in 0...num_to_find
		book_nums.push rand(lib.execute("Select count(title) from books")[0][0])
	end
	found_list = lib.execute("SELECT * FROM books JOIN authors ON books.author_id = authors.id WHERE books.id = #{book_nums[0]}")
	show_books(found_list)
	for k in 1...num_to_find
		found_list = lib.execute("SELECT * FROM books JOIN authors ON books.author_id = authors.id WHERE books.id = #{book_nums[k]}")
		append_to_list(found_list, 0)
	end
end

#things I want to be able to do in the user interface:

# 1 search by title, or by author
# 2 narrow my search from author down
#      this might get down to selecting by book ID
# 2-a- implement a wildcard or short search function
	#2 -A+ -#it would be pretty slick if this ignored "the"

# Check out a book once selected.
def checkout_book(book_id, lib)
	lib.execute("UPDATE books SET on_shelf = 'false' WHERE books.id = #{book_id}")
end
# Return a book once selected.
def return_book(book_id, lib)
	lib.execute("UPDATE books SET on_shelf = 'true' WHERE books.id = #{book_id}")
end	
# add a new book.
def add_book(parsed_line, lib)
	parsed_line.each do |word|
		word.strip!
	end
	# and then add the data to the library
	# dont add the same author twice!
	add_author = "INSERT INTO authors (l_name, f_name) SELECT '#{parsed_line[0].gsub("'"){"''"}}','#{parsed_line[1].gsub("'"){"''"}}' WHERE NOT EXISTS(SELECT 1 FROM authors WHERE l_name = '#{parsed_line[0].gsub("'"){"''"}}' AND f_name = '#{parsed_line[1].gsub("'"){"''"}}')"
	lib.execute(add_author)
	# but we will always add the book!
	add_book = "INSERT INTO books (title, section, on_shelf, author_id) VALUES ('#{parsed_line[2].gsub("'"){"''"}}','#{parsed_line[4]}', '#{parsed_line[5]}', (SELECT id FROM authors WHERE l_name = '#{parsed_line[0].gsub("'"){"''"}}' AND f_name = '#{parsed_line[1].gsub("'"){"''"}}'))"
	lib.execute(add_book)
	puts "added #{parsed_line[2]} by #{parsed_line[1]} #{parsed_line[0]}"
end

# a user defined search
def search_lib(lib)
	search_type = ''
	while search_type != 'g'
		puts "search by [A]uthor, [T]itle, or [I]ndex number, or [G]o back"
		search_type = gets.chomp.downcase[0]
		if search_type == 'a'
			puts "author last name to search?"
			search_term = gets.chomp.downcase.split.map(&:capitalize).join(' ')
			test_book = searchby("authors.l_name", search_term, lib)
			show_books(test_book)
		elsif search_type == 't'
			puts "title to search?"
			search_term = gets.chomp.downcase.split.map(&:capitalize).join(' ')
			test_book = searchby("books.title", search_term, lib)
			show_books(test_book)
		elsif search_type == 'i'
			puts "index to search?"
			search_term = gets.chomp.downcase
			test_book = searchby("books.id", search_term, lib)
			show_books(test_book)
		elsif search_type != 'g'
			puts "did not understand query"
		else
			puts "***** returning to main menu *****"
			puts ""
			puts ""
		end
	end
end

################# DRIVER CODE ####################

=begin
import('importbooklist.txt', lib)
findbook = lib.execute("select * from books join authors on books.author_id = authors.id where authors.l_name = 'Dostoevsky' ORDER BY books.title")
show_books(findbook)
browse(8,lib)
test_book = searchby('authors.id', 3, lib)
show_books(test_book)
checkout_book(5, lib)
test_book = searchby('authors.id', 3, lib)
show_books(test_book)
return_book(5,lib)
test_book = searchby('authors.id', 3, lib)
show_books(test_book)
test_book = searchby("authors.l_name", "Card", lib)
show_books(test_book)
=end

############## the demonstration startup code ###########
puts "Welcome to the librarian database!"

if lib.execute("Select count(title) from books")[0][0] == 0
	user_command = ''
	while user_command != 'e' && user_command != 'l'
		puts "It seems there is no library - you can [L]oad the library, or [E]xit the program"
		user_command = gets.chomp.downcase[0]
		if user_command == 'l'
			import('importbooklist.txt', lib)
		elsif user_command != 'e'
			puts "I did not understand that command"
		end
	end
end

############## the main UI ############################
user_command = ''
while user_command != 'e'
	puts "would you like to [S]earch, [C]heckout, [R]eturn, [B]rowse, or [A]dd a new book, or [E]xit?"
	user_command = gets.chomp.downcase[0]
	if user_command == 's'
		search_lib(lib)
	elsif user_command == 'c'
		puts "enter the index number of the book to checkout, or go [B]ack to search books"
		ind_num = gets.chomp
		if ind_num.to_i != 0
			checkout_book(ind_num.to_i,lib)
			checkedout_book = searchby("books.id", ind_num.to_i, lib)
			puts "Checked out!"
			show_books(checkedout_book)
		elsif ind_num != 'b'
			puts "an index number should be an integer - you can search the catalog to find the index number of a specific book if needed"
		end
	elsif user_command == 'r'
		puts "enter the index number of the book to return, or go [B]ack to search books"
		ind_num = gets.chomp
		if ind_num.to_i != 0
			return_book(ind_num.to_i,lib)
			returned_book = searchby("books.id", ind_num.to_i, lib)
			puts "returned!"
			show_books(returned_book)
		elsif ind_num != 'b'
			puts "an index number should be an integer - you can search the catalog to find the index number of a specific book if needed"
		end
	elsif user_command == 'b'
		puts "how many books would you like to browse through?"
		browse_num = gets.chomp.to_i
		browse(browse_num, lib)
	elsif user_command == 'a'
		new_book_info = ["","","","","",'false']
		puts "Input Author Last Name:"
		new_book_info[0] = gets.chomp.gsub("'"){"''"}
		puts "Input Author First Name:"
		new_book_info[1] = gets.chomp.gsub("'"){"''"}
		puts "Input Title:"
		new_book_info[2] = gets.chomp.gsub("'"){"''"}
		puts "Iput Section:"
		new_book_info[4] = gets.chomp.gsub("'"){"''"}
		puts "Is this book avaliable for check-out? [Y/N]"
		available = gets.chomp.downcase[0]
		if available == 'y'
			new_book_info[5] = 'true'
		end
		add_book(new_book_info, lib)
	end
end

