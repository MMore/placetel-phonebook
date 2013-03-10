source :rubygems

gem 'sinatra', '~> 1.3.3'
gem 'sinatra-twitter-bootstrap'
gem 'json', '~> 1.7.6'

group :test do
  gem 'rspec', '~> 2.11.0'
  gem 'rack-test', '~> 0.6.1'
  gem 'guard-rspec', '~> 1.2.1'

  group :darwin do                                  # Install on Mac OS only
    gem 'rb-fsevent', '~> 0.9.1', :require => false # Used by guard
  end
end
