# frozen_string_literal: true

require_relative "lib/strong_routes/version"

Gem::Specification.new do |spec|
  spec.name = "strong_routes"
  spec.version = StrongRoutes::VERSION
  spec.authors = ["Adam Hutchison"]
  spec.email = ["liveh2o@gmail.com"]

  spec.summary = "Middleware to reject/allow requests before allocating a database connection or any resources"
  spec.description = spec.summary
  spec.homepage = "https://github.com/liveh2o/strong_routes"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage + "/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rack"
end
