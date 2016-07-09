# require gems
require 'sinatra'
require 'sqlite3'
require 'sinatra/reloader' if development?

set :public_folder, File.dirname(__FILE__) + '/static'

db = SQLite3::Database.new("students.db")
db.results_as_hash = true

# show students on the home page
get '/' do
  @students = db.execute("SELECT * FROM students")
  erb :home
end

#send to new students form
get '/students/new' do
  erb :new_student
end

#send to transfer students form
get '/students/transfer' do
	erb :transfer_campus
end

# create new students via
# a form
post '/students' do
  db.execute("INSERT INTO students (name, campus, age) VALUES (?,?,?)", [params['name'], params['campus'], params['age'].to_i])
  redirect '/'
end

post '/new_campus' do
	if db.execute("SELECT EXISTS(SELECT 1 FROM students WHERE name = ?)", [params['name']])
		p "found student by name #{params[:name]}"	
  		db.execute("UPDATE students SET campus = ? WHERE name = ?", [params['new_campus'], params['name']])
  		p db.execute("SELECT * FROM students WHERE name = ?", params['name'])
 	else
 		p "did not find student by name"
 	end
 	redirect '/'
 end

# add static resources