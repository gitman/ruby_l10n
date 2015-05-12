Gem::Specification.new do |s|
  s.name        = 'ruby_l10n'
  s.version     = '0.0.1'
  s.summary     = "A gem that provide L10n functionalities"
  s.description = "A gem that provide L10n functionalities"
  s.authors     = ['Linh Chau']
  s.email       = 'chauhonglinh@gmail.com'
  s.files       = [
                    './ruby_l10n.gemspec', 'lib/ruby_l10n.rb',
                  ]
  s.homepage    = 'https://github.com/linhchauatl/ruby_l10n'
  s.license     = 'MIT'
  s.add_runtime_dependency 'logging', '~> 0'
  s.add_runtime_dependency 'activesupport'
  s.add_runtime_dependency 'config_service'
  s.add_development_dependency 'minitest'
end