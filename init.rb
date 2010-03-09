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

class Main < Monk::Glue
  set :app_file, __FILE__
  use Rack::Session::Cookie
end

# Connect to redis database.
Ohm.connect(settings(:redis))

# Sequel.oracle host: "ec2-75-101-186-222.compute-1.amazonaws.com", user: "ruby", password: "ruby", port: 1521
Sequel.sqlite database: "development.sqlite3"

# Load all application files.
Dir[root_path("app/**/*.rb")].each do |file|
  require file
end

if defined? Encoding
  Encoding.default_external = Encoding::UTF_8
end

Main.run! if Main.run?
