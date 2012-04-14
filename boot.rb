# encoding: utf-8
# put some defaults to ENV
ENV['RACK_ENV'] ||= "development"

require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require(:default, ENV['RACK_ENV'].to_sym) if defined?(Bundler)
# this is not included automatically
require 'active_support/core_ext'

# configuration
MultiJson.engine = :yajl

AppDir = File.expand_path(File.join(File.dirname(__FILE__))) + '/'

# global yml configuration
config = YAML.load_file(File.join(AppDir, 'config', 'config.yml'))
env_config = config[ENV['RACK_ENV']]
::AppConfig = OpenStruct.new(env_config)