ROOT_DIR = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT_DIR

require "rubygems"

begin
  require "vendor/dependencies/lib/dependencies"
rescue LoadError
  require "dependencies"
end

require "monk/glue"
require "ohm"
require "haml"
require "sass"
require "sequel"
require "sinatra/r18n"

class Main < Monk::Glue
  register Sinatra::R18n

  set :app_file, __FILE__
  use Rack::Session::Cookie
  use Rack::Runtime
end

# Connect to Redis database.
#Ohm.connect(settings(:redis))

# Connect to the Sqlite3 database.
db = settings(:sequel)
Sequel.send(db.delete(:adapter), *[db.delete(:database), db.empty? ? nil : db.merge(logger: logger)])

# Load all application files.
Dir[root_path("app/**/*.rb")].each do |file|
  require file
end

if defined? Encoding
  Encoding.default_external = Encoding::UTF_8
end

Main.run! if Main.run?
