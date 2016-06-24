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
puts booklist
authorlist = lib.execute("SELECT * FROM authors")
p authorlist
joinlist = lib.execute("SELECT * FROM books JOIN authors ON books.author_id = authors.id")
p joinlist
