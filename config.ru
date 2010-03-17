require "init"

Main.set :run, false
Main.set :environment, :production

Main.use Rack::Runtime

run Main
