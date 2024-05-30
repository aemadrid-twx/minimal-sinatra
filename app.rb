#!/bin/env ruby
require 'sinatra'
require 'sinatra/json'

begin
  REVISION = `git rev-parse --short HEAD`.chomp
rescue => e
  REVISION = format 'ERROR: %s : %s', e.class.name, e.message
end

get '/' do
  json status: 'ok', revision: REVISION
end

get '/env' do
  env_vars = ENV.keys.sort.each_with_object({}) { |k, h| h[k] = ENV[k] }
  json status: 'ok', env: env_vars
end

get '/status' do
  content_type :text
  "OK"
end
