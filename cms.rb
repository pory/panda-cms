# encoding: utf-8
require_relative 'boot'

require 'rubygems'
require 'sinatra'
require 'haml'

require_relative 'models/text'
require_relative 'helpers/application'

class Cms < Sinatra::Base

  set :views, File.dirname(__FILE__) + '/views'
  set :public, File.dirname(__FILE__) + '/public'
  set :haml, :format => :html5

  before do
    redirect("http://www." + request.host_with_port + request.fullpath) if !request.host_with_port.include?("localhost") && !/^www/.match(request.host)
  end

  get '/' do
    @index = Text.find_or_create('index')  
    haml :index
  end

  get '/login' do
    protected!
    redirect '/'
  end

end