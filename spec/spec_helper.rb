require 'equivalent-xml'
require 'equivalent-xml/rspec_matchers'
require 'simplecov'

require 'xliffer'

SimpleCov.start

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end
