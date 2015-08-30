unless RUBY_VERSION.match(/\A1\.8/)
  require 'codeclimate-test-reporter'
  require 'simplecov'
  CodeClimate::TestReporter.start
  SimpleCov.start
end

require 'equivalent-xml'
require 'equivalent-xml/rspec_matchers'

require 'xliffer'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end
