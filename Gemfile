source 'https://rubygems.org'

gem 'daemons'
gem 'event_bus'
gem 'slop'

group :development do
  gem 'pry'
  gem 'pry-doc'
  gem 'spectator-emacs', github: 'ignisf/spectator-emacs', branch: 'bump-spectator'
end

group :test do
  gem 'rake'
end

group :test do
  gem 'fakefs', :require => "fakefs/safe"
  gem "rspec", "~> 3.0.0.beta1"
  gem 'simplecov', require: false
end

platforms :rbx do
  gem 'racc'
  gem 'rubysl', '~> 2.0'
  gem 'psych'
end
