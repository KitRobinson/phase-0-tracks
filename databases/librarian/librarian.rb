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
	f.close
end


def searchby(criteria, value, lib)
	value = value.gsub("'"){"''"}
	return lib.execute("Select * from books join authors on books.author_id = authors.id WHERE #{criteria} = #{value})")
end

def show_books(found_list)
	puts ("Author                    Title                                    Section              Available")
	puts ("--------------------------------------------------------------------------------------------")
	for i in 0...found_list.size
		puts ("#{(found_list[i][6]+', '+found_list[i][7]).truncate(25).ljust(25, " ")} #{found_list[i][1].truncate(40).ljust(40," ")} #{found_list[i][3].truncate(20).ljust(20," ")} #{found_list[i][4]}")
	end
end

def browse(num_to_find, lib)
	book_nums = []
	for j in 0...num_to_find
		book_nums.push rand(lib.execute("Select count(title) from books")[0][0])
		#!!!!!!!! problem:  can I pass an array here, as a list of WHERE id = 1, 2, 3, etc?  
		#!!!!!!!! if not, can I make an entirely new table and join tnem to books in some goofy way?
	end
	found_list = lib.execute("SELECT * FROM books JOIN authors ON books.author_id = authors.id WHERE books.id = #{book_nums}")
	show_books(found_list)
end

################# DRIVER CODE ####################

import('shortbooklist.txt', lib)
findbook = lib.execute("select * from books join authors on books.author_id = authors.id where books.id < 10 ORDER BY authors.l_name")
show_books(findbook)
browse(1,lib)