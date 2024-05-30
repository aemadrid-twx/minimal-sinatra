#!/bin/env ruby
require 'sinatra'
require 'sinatra/json'

ENV_PASSWORD = ENV.fetch('ENV_PASSWORD') { '1234' }

ENVS = ENV.keys.sort.each_with_object({}) { |k, h| h[k] = ENV[k] }

INFO = {
  url: ENV.fetch('COOLIFY_URL') { 'missing' },
  fqdn: ENV.fetch('COOLIFY_FQDN') { 'missing' },
  host: ENV.fetch('HOST') { 'missing' },
  port: ENV.fetch('PORT') { 'missing' },
  branch: ENV.fetch('COOLIFY_BRANCH') { 'missing' },
  revision: ENV.fetch('SOURCE_COMMIT') { 'missing' }
}

get '/' do
  json status: 'ok'
end

get '/info' do
  info = params[:pass] == ENV_PASSWORD ? INFO : {}

  json status: 'ok', info: info
end

get '/env' do
  envs = params[:pass] == ENV_PASSWORD ? ENVS : {}

  json status: 'ok', env: envs
end

get '/status' do
  content_type :text
  "OK"
end
