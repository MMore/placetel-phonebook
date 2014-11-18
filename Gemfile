source 'https://rubygems.org'

gem 'sinatra', '~> 1.4.5'
gem 'sinatra-twitter-bootstrap', '~> 2.3.3'
gem 'json', '~> 1.7.6'

group :test do
  gem 'rspec', '~> 2.14.1'
  gem 'rack-test', '~> 0.6.1'
  gem 'guard-rspec', '~> 1.2.1'

  group :darwin do                                  # Install on Mac OS only
    gem 'rb-fsevent', '~> 0.9.1', :require => false # Used by guard
  end
end
