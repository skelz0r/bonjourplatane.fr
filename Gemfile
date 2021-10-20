source "https://rubygems.org"

gem "jekyll-feed", "~> 0.12"
gem 'webrick'
gem "minima", github: "jekyll/minima"

group :jekyll_plugins do
  gem "github-pages"
end

platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", "~> 1.2"
  gem "tzinfo-data"
end

group :test do
  gem "rspec"
  gem "webmock"
end

gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]
