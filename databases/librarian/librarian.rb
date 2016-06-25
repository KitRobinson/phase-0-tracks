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
puts create_author_table
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
puts create_book_table
lib.execute(create_book_table)

# define truncate method for strings to fit into display table
class String
	def truncate(max)
		length > max ? "#{self[0...max-3]}..." : self
	end
end

############### DEFINE DRIVER METHODS #######################

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
	value.to_i != 0 ? value.to_i : value
	return lib.execute("Select * from books join authors on books.author_id = authors.id WHERE #{criteria} = #{value}")
end


# display a more nicely formatted table of returned items
def show_books(found_list)
	puts ""
	puts ""
	puts ("Author                    Title                                    Section              Available")
	puts ("--------------------------------------------------------------------------------------------")
	for i in 0...found_list.size
		puts ("#{(found_list[i][6]+', '+found_list[i][7]).truncate(25).ljust(25, " ")} #{found_list[i][1].truncate(40).ljust(40," ")} #{found_list[i][3].truncate(20).ljust(20," ")} #{found_list[i][4]}")
	end
end

# add an item to the formatted table
def append_to_list(found_list, index_num)
	puts ("#{(found_list[index_num][6]+', '+found_list[index_num][7]).truncate(25).ljust(25, " ")} #{found_list[index_num][1].truncate(40).ljust(40," ")} #{found_list[index_num][3].truncate(20).ljust(20," ")} #{found_list[index_num][4]}")	
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
	add_author = "INSERT INTO authors (l_name, f_name) SELECT '#{parsed_line[0]}','#{parsed_line[1]}' WHERE NOT EXISTS(SELECT 1 FROM authors WHERE l_name = '#{parsed_line[0]}' AND f_name = '#{parsed_line[1]}')"
	lib.execute(add_author)
	# but we will always add the book!
	add_book = "INSERT INTO books (title, section, on_shelf, author_id) VALUES ('#{parsed_line[2].gsub("'"){"''"}}','#{parsed_line[4]}', '#{parsed_line[5]}', (SELECT id FROM authors WHERE l_name = '#{parsed_line[0]}' AND f_name = '#{parsed_line[1]}'))"
	lib.execute(add_book)
	puts "added #{parsed_line[2]} by #{parsed_line[1]} #{parsed_line[0]}"
	end
################# DRIVER CODE ####################


#import('importbooklist.txt', lib)
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

