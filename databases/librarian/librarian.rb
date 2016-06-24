#create a librarian program which tracks books in a database,
#and keeps an eye on whether they are checked out or returned

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

#add a test author
lib.execute("INSERT INTO authors (l_name, f_name) VALUES ('Robinson', 'Kit')")
lib.execute("INSERT INTO authors (l_name, f_name) VALUES ('Lancaster', 'Blythe')")


#add a test book
lib.execute("INSERT INTO books (title, author_id, section, on_shelf) VALUES ('Goodmight Noon', 1, 'Childrens', 'true')")
lib.execute("INSERT INTO books (title, author_id, section, on_shelf) VALUES ('Leo the Lapp', 1, 'Childrens', 'true')")
lib.execute("INSERT INTO books (title, author_id, section, on_shelf) VALUES ('The Hermaneutical Bealgeshichte', 2, 'Philosophy', 'true')")

#return a few sqlcalls as hashes
booklist = lib.execute("SELECT * FROM books")
authorlist = lib.execute("SELECT * FROM authors")
joinlist = lib.execute("SELECT * FROM books JOIN authors ON books.author_id = authors.id")

#output the joined list
joinlist.each do |book|
	puts "#{book['title']} by #{book['l_name']} is a #{book['section']} book."
end

#open the text file containing the booklist from the library
f = File.open('importbooklist.txt')

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
	puts "add author #{parsed_line[0]}"
	# but we will always add the book!
	add_book = "INSERT INTO books (title, section, on_shelf, author_id) VALUES ('#{parsed_line[2].gsub("'"){"''"}}','#{parsed_line[4]}', '#{parsed_line[5]}', (SELECT id FROM authors WHERE l_name = '#{parsed_line[0]}' AND f_name = '#{parsed_line[1]}'))"
	puts add_book
	lib.execute(add_book)
	puts "add book #{parsed_line[3]}"
end
f.close
