# encoding: utf-8
require_relative 'boot'

require 'rubygems'
require 'sinatra'
require 'haml'

require_relative 'models/text'
require_relative 'helpers/cms_helper'

class Cms < Sinatra::Base

  set :views, File.dirname(__FILE__) + '/views'
  set :public_folder, File.dirname(__FILE__) + '/public'
  set :haml, :format => :html5
  
  helpers CmsHelper

  before do
    redirect("http://www." + request.host_with_port + request.fullpath) if !request.host_with_port.include?("localhost") && !/^www/.match(request.host)
  end

  get '/' do
    @index = Text.find_or_create('index')  
    haml :index
  end

  get '/blog' do
    @blog = Text.find_or_create('blog')  
    haml :blog
  end
  
  put '/texts/:document/:key' do
    save_text!(:document => params[:document], :text => params[:text], :key => params[:key])
  end  
  
  post '/texts/:document/:key' do
    save_text!(:document => params[:document], :text => params[:text], :key => params[:key])
  end  

  get '/login' do
    protected!
    redirect '/'
  end

end