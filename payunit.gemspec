# frozen_string_literal: true

require_relative "lib/payunit/version"

Gem::Specification.new do |spec|
  spec.name = "payunit"
  spec.version = Payunit::VERSION
  spec.authors = ["Lekunze Stanley Enow"]
  spec.email = ["hguruman@gmail.com"]

  spec.summary = "Cameroon Payment Gateway."
  spec.description = "To aid Cameroon businesses to make both national and
                      international payments using MTN and Orange Mobile Money, Paypal, Credit Card and Express Union."
  spec.homepage = "https://rubygems.org/gems/payunit"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/happiguru/payunit"
  spec.metadata["changelog_uri"] = "https://github.com/happiguru/payunit/issues"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "base64"
  spec.add_dependency "byebug"
  spec.add_dependency "dotenv-rails"
  spec.add_dependency "faraday"
  spec.add_dependency "faraday-net_http"
  spec.add_dependency "json_pure"
  spec.add_dependency "launchy"
  spec.add_dependency "securerandom"
  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
