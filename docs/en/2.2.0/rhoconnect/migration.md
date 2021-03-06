Migrating RhoSync application to RhoConnect
===

The best way of migrating your Rhosync app to Rhoconnect is to re-generate the application skeleton
using Rhoconnect, then integrate all of your implementation specifics into it.
However, if you prefer to migrate your Rhosync app manually, perform the steps in this document:

## Install the Bundler
Install the `bundler` gem:

	:::term
	$ [sudo] gem install bundler

## Create the Gemfile
Create a new `Gemfile` file in your application directory with the following content:

	:::ruby
	source 'http://rubygems.org'

	gem 'rhoconnect', '3.0.0'

	# Helps with some of the limitations of green threads, not needed in ruby 1.9.x
	gem 'SystemTimer', '~> 1.2.3', :platforms => :ruby_18

	platforms :jruby do
	  gem 'jdbc-sqlite3', ">= 3.7.2"
	  gem 'dbi', ">= 0.4.5"
	  gem 'dbd-jdbc', ">= 0.1.4"
	  gem 'jruby-openssl', ">= 0.7.4"
	  gem 'warbler'
	end

	gem 'sqlite3', ">= 1.3.3", :platforms => [:ruby, :mswin, :mingw]

	# For jruby trinidad JRuby web server is used
	gem 'trinidad',  :platforms => :jruby

	group :development do
	  # By default to run application thin web server is used
	  gem 'thin', :platforms => [:ruby, :mswin, :mingw]
	end

	group :test do
	  gem 'rack-test', '>= 0.5.3', :require => "rack/test"
	  gem 'rspec', '~> 2.6.0'
	  gem 'rcov', '>= 0.9.8'
	end
	

## Edit the Rakefile

Adjust the existing `Rakefile` by changing `rhosync` to `rhoconnect`.

Change this:
	
	:::ruby
	begin
	  require 'vendor/rhosync/lib/rhosync/tasks'
	  require 'vendor/rhosync/lib/rhosync'
	rescue LoadError
	  require 'rhosync/tasks'
	  require 'rhosync'
	end
	
to this:

	:::ruby
	begin
	  require 'vendor/rhoconnect/lib/rhoconnect/tasks'
	  require 'vendor/rhoconnect/lib/rhoconnect'
	rescue LoadError
	  require 'rhoconnect/tasks'
	  require 'rhoconnect'
	end

## Edit config.ru

Adjust `config.ru` file by performing the following steps:

1) Change the section shown below to replace `rhosync` with `rhoconnect`.

Change this:

	:::ruby
	begin
	  require 'vendor/rhosync/lib/rhosync/tasks'
	  require 'vendor/rhosync/lib/rhosync'
	rescue LoadError
	  require 'rhosync/tasks'
	  require 'rhosync'
	end

to this:

	:::ruby
	begin
	  require 'vendor/rhoconnect/lib/rhoconnect/tasks'
	  require 'vendor/rhoconnect/lib/rhoconnect'
	rescue LoadError
	  require 'rhoconnect/tasks'
	  require 'rhoconnect'
	end

2) Change all `Rhosync` references to `Rhoconnect`.

For example, change this:

	:::ruby
	Rhosync::Server.disable :run
	
to this:

	:::ruby
	Rhoconnect::Server.disable :run
	
## Edit application.rb

Adjust `application.rb` file with the following steps:

1) Change the name of the base class from:

	:::ruby
	class Application < Rhosync::Base
	
to:

	:::ruby
	class Application < Rhoconnect::Base

## Edit spec/spec_helper.rb

Edit your `spec/spec_helper.rb` file to contain the following:

	:::ruby
	require 'rubygems'

	# Set environment to test
	ENV['RHO_ENV'] = 'test'
	ROOT_PATH = File.expand_path(File.join(File.dirname(__FILE__),'..'))
	Bundler.require(:default, ENV['RHO_ENV'].to_sym)

	# Try to load vendor-ed rhoconnect, otherwise load the gem
	begin
	  require 'vendor/rhoconnect/lib/rhoconnect'
	rescue LoadError
	  require 'rhoconnect'
	end

	# Load our rhoconnect application
	require './application'
	include Rhoconnect

	require 'rhoconnect/test_methods'

	module RSpec
	  module Core
	    module SharedExampleGroup
	    private
	      def ensure_shared_example_group_name_not_taken(name)
	      end
	    end
	  end
	end

	shared_examples_for "SpecHelper" do
	  include Rhoconnect::TestMethods
  
	  before(:each) do
	    Store.flush_all
	    Application.initializer(ROOT_PATH)
	  end  
	end

## Edit spec files
all of your spec files should be modified from:

	:::ruby
	describe "<SampleSpec>" do
  		it_should_behave_like "SpecHelper"
		...
	end

to:
	
	:::ruby
	describe "<SampleSpec>" do
  		it_should_behave_like "SpecHelper" do
			...
		end
	end
	
## Edit implementation files
Modify all of your application implementation files by changing the `Rhosync` references
to `Rhoconnect`.
