# encoding: utf-8

GemSpec = Gem::Specification.new do |gem|
  gem.name = 'test-more'
  gem.version = '0.0.2'
  gem.license = 'MIT'
  gem.required_ruby_version = '>= 1.9.1'

  gem.authors << 'Ingy döt Net'
  gem.email = 'ingy@ingy.net'
  gem.summary = "Port of Perl's Test::More TAP test framework"
  gem.description = <<-'.'
Port of Perl's Test::More TAP test framework.
.
  gem.homepage = 'https://github.com/ingydotnet/test-more-rb'

  gem.files = `git ls-files`.lines.map{|l|l.chomp}
end
