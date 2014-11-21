# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment.rb", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'database_cleaner'
require "paperclip/matchers"
require 'image_size'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
RSpec.configure do |config|
	config.use_transactional_fixtures = false
	
	# For extended backtrace info, uncomment the next line
	# config.backtrace_clean_patterns = []
  config.after(:each) do
    DatabaseCleaner.clean
  end
end
Spec::Runner.configure do |config|
  config.include Paperclip::Shoulda::Matchers
end