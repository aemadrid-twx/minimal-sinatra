#!/bin/env ruby
require 'sinatra'
require 'sinatra/json'

REVISION = ENV.fetch('SOURCE_COMMIT') { `git rev-parse --short HEAD`.chomp }
ENV_PASSWORD = ENV.fetch('ENV_PASSWORD') { '1234' }

get '/' do
  json status: 'ok', revision: REVISION
end

get '/env' do
  env_vars = if params[:pass] == ENV_PASSWORD
               ENV.keys.sort.each_with_object({}) { |k, h| h[k] = ENV[k] }
             else
               {}
             end
  json status: 'ok', env: env_vars
end

get '/status' do
  content_type :text
  "OK"
end
