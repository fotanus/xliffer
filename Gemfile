source "http://rubygems.org"

gem 'nokogiri', '~> 1.5.10'

group :test do
  unless RUBY_VERSION.match(/\A1\.8/)
    gem "codeclimate-test-reporter", :require => false
  end
end

group :development do
  gem 'rspec', '~> 2'
  gem 'simplecov'
end
