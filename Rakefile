require "bundler/gem_tasks"

task :build do
  `gem build tug.gemspec`
end

task :install => [:build] do
  `gem install tug`
end