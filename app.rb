#!/bin/env ruby
require 'sinatra'
require 'sinatra/json'

REVISION = ENV.fetch('SOURCE_COMMIT') { `git rev-parse --short HEAD`.chomp }
ENV_PASSWORD = ENV.fetch('ENV_PASSWORD') { '1234' }

get '/' do
  json status: 'ok'
end

get '/info' do
  json url: ENV.fetch('COOLIFY_URL') { 'missing' },
       fqdn: ENV.fetch('COOLIFY_FQDN') { 'missing' },
       host: ENV.fetch('HOST') { 'missing' },
       port: ENV.fetch('PORT') { 'missing' },
       branch: ENV.fetch('COOLIFY_BRANCH') { 'missing' },
       revision: ENV.fetch('SOURCE_COMMIT') { 'missing' }
end

get '/env' do
  if params[:pass] == ENV_PASSWORD
    envs = ENV.keys.sort.each_with_object({}) do |k, h|
      h[k] = ENV[k]
    end
  else
    envs = {}
  ends

  json status: 'ok', env: envs
end

get '/status' do
  content_type :text
  "OK"
end
