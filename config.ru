require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :development)

require 'logger'

require ::File.expand_path('../lib/db',  __FILE__)
require ::File.expand_path('../lib/app',  __FILE__)
run Sinatra::Application