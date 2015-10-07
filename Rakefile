require 'rubygems'
require 'yaml'

# Ensure that we can always load relative files
$:.unshift File.dirname( __FILE__)

require 'lib/Runner'

task :default => [:build]

task :npm_install do
  run "npm install"
end

task :build => [:npm_install, :lint_coffeescript, :test, :webpack]

task :lint_coffeescript do

  run_with_params do |args|
    puts '== CoffeeScript Lint =='

    # If only .coffee files have changed, then only lint those files.
    coffee_files = args.select { |file| file.end_with? '.coffee' }
    paths = args.length > 0 && args.length == coffee_files.length ? args : ["player/controllers", "player/directives", "player/services"]

    setup = 'PATH=node_modules/.bin:$PATH && export PATH && '
    run setup + "coffeelint -f coffeelint.json '#{paths.join("' '")}'"
  end

end

task :webpack do
  setup = 'PATH=node_modules/.bin:$PATH && export PATH && '
  run setup + "webpack player/main.coffee player/app.js"
end

task :test do
  run "npm run test-full"
end

def deploy(env)
  host = env[:host]

  puts "== Deploy to #{env[:name]} =="

  # Remove old upload
  ssh "rm -r '#{env[:dir]}-upload'", host, :port => env[:port], :ignore_failure => true

  # Upload new version
  scp "./", "#{env[:dir]}-upload", host, :port => env[:port], :excludes => [".git"]

  # Remove old backup
  ssh "rm -R '#{env[:dir]}-backup'", host, :port => env[:port], :ignore_failure => true

  # Move live to backup and new to live
  ssh "mv '#{env[:dir]}' '#{env[:dir]}-backup' ; mv '#{env[:dir]}-upload' '#{env[:dir]}'", host, :port => env[:port]
end

#
# Useful functions
#

def run_with_params

  # ARGV contains the name of the rake task and all of the arguments.
  # Remove/shift the first element, i.e. the task name.
  ARGV.shift

  yield(ARGV)

  # By default, rake considers each 'argument' to be the name of an actual task.
  # It will try to invoke each one as a task.  By dynamically defining a dummy
  # task for every argument, we can prevent an exception from being thrown
  # when rake inevitably doesn't find a defined task with that name.
  ARGV.each do |arg|
    task arg.to_sym do ; end
  end

end

def run(command, ignore_failure = false)
  Runner.new($stdout).run command, ignore_failure
end

def ssh(command, domain, options = {})
  options = { :user => 'guru', :port => 2201, :ignore_failure => false }.merge(options)

  # Some shell magic to quote and single quotes in the command
  escaped_command = command.gsub("'", "'\\\\''")
  Runner.new($stdout).run "ssh -p #{options[:port].to_s} #{options[:user]}@#{domain} '#{escaped_command} 2>&1'", options[:ignore_failure]
end

def scp(from, to, domain, options = {})
  options = { :user => 'guru', :port => 2201, :ignore_failure => false, :excludes => [] }.merge(options)
  excludes = options[:excludes].map { |exclude| "--exclude \"#{exclude}\"" }.join(" ")
  Runner.new($stdout).run "rsync --delete -a --rsh='ssh -p#{options[:port].to_s}' #{excludes} --rsync-path=/ec/bin/rsync #{from} #{options[:user]}@#{domain}:#{to}", options[:ignore_failure]
end
