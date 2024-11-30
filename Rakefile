require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs.push "spec"
  t.pattern = "spec/**/*_spec.rb"
  t.verbose = false
end

require "standard/rake"

task default: %i[test standard:fix]
task spec: :test
