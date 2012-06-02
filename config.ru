#Process.setrlimit(Process::RLIMIT_NOFILE, 4096, 65536) if defined?(Process) && defined?(Process::RLIMIT_NOFILE)
require 'sass/plugin/rack'
require File.join(File.dirname(__FILE__), "cms")
Sass::Plugin.options[:template_location] = 'public/stylesheets'
use Sass::Plugin::Rack
run Cms