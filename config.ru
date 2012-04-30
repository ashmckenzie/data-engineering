require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :development)

require ::File.expand_path('../lib/app',  __FILE__)
run Sinatra::Application