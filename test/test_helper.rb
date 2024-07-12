require 'simplecov'
SimpleCov.start('rails')
# SimpleCov.start('rails') { enable_coverage_for_eval }

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/autorun'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    # TODO: Needed to comment the line below due to problems with simplecov.
    # parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    def log_in_as(user)
      post session_url, params: { session: { email: user.email, password: 'secret' } }
    end

    # Add more helper methods to be used by all tests here...
  end
end
