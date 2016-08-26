Gem::Specification.new do |s|
  s.name        = 'manga_fetch'
  s.version     = '0.1.0'
  s.date        = Time.now.getgm.to_s.split.first
  s.summary     = "manga_fetch is a gem to download a manga"
  s.description = "initialization of the project with the basic features"
  s.authors     = ["Arthur Poulet"]
  s.email       = 'arthur.poulet@mailoo.org'
  s.files       = %w(
lib/manga_fetch.rb

Gemfile
Gemfile.lock

README.md

bin/manga_fetch
)

  s.executables = %w(
manga_fetch
)

  s.homepage    =
    'http://rubygems.org/gems/manga_fetch'
  s.license       = 'WTFPL'
  s.cert_chain  = ['certs/nephos.pem']
  s.signing_key = File.expand_path('~/.ssh/gem-private_key.pem') if $0 =~ /gem\z/

  s.add_dependency 'nomorebeer', '~> 1', '>= 1.1.1'
  s.add_dependency 'colorize', '~> 0.8', '>= 0.8.1'
  s.add_dependency 'mechanize', '~> 2.7', '>= 2.7.5'
end
