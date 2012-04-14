#Process.setrlimit(Process::RLIMIT_NOFILE, 4096, 65536) if defined?(Process) && defined?(Process::RLIMIT_NOFILE)
require File.join(File.dirname(__FILE__), "cms")
run Cms