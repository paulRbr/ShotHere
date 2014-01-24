#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

# Ugly Hack for requirejs-rails gem with Rails 4
def ruby_rake_task(task)
  Rake::Task[task].invoke
end

require File.expand_path('../config/application', __FILE__)

Shothere::Application.load_tasks
