
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sudoku_genius/version"

Gem::Specification.new do |spec|
  spec.name          = "sudoku_genius"
  spec.version       = SudokuGenius::VERSION
  spec.authors       = ["Adam Booth"]
  spec.email         = ["4rlm@protonmail.ch"]

  spec.summary       = %q{SudokuGenius solves ALL sudoku puzzles, including mathematician Arto Inkala's world's most difficult sudoku puzzle}
  spec.description   = %q{SudokuGenius solves ALL sudoku puzzles, including mathematician Arto Inkala's  world's most difficult sudoku puzzle.}

  spec.homepage      = 'https://github.com/4rlm/sudoku_genius'
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '~> 2.5.1'
  spec.add_dependency 'activesupport', '~> 5.2'
  spec.add_dependency 'crm_formatter', '~> 2.64'
  spec.add_dependency 'mechanizer', '~> 1.12'
  spec.add_dependency 'scrub_db', '~> 2.23'
  spec.add_dependency 'url_verifier', '~> 2.12'
  spec.add_dependency 'utf8_sanitizer', '~> 2.16'

  # spec.add_dependency "activesupport-inflector", ['~> 0.1.0']
  spec.add_development_dependency 'bundler', '~> 1.16', '>= 1.16.2'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'rake', '~> 12.3', '>= 12.3.1'
  spec.add_development_dependency 'rspec', '~> 3.7'
  # spec.add_development_dependency 'byebug', '~> 10.0', '>= 10.0.2'
  # spec.add_development_dependency 'class_indexer', '~> 0.3.0'
  # spec.add_development_dependency 'irbtools', '~> 2.2', '>= 2.2.1'
  # spec.add_development_dependency 'rubocop', '~> 0.56.0'
  # spec.add_development_dependency 'ruby-beautify', '~> 0.97.4'
  # spec.add_runtime_dependency 'library', '~> 2.2'
  # spec.add_dependency 'activerecord', '>= 3.0'
  # spec.add_dependency 'actionpack', '>= 3.0'
  # spec.add_dependency 'polyamorous', '~> 1.3.2'
  # spec.add_development_dependency 'machinist', '~> 1.0.6'
  # spec.add_development_dependency 'faker', '~> 0.9.5'
  # spec.add_development_dependency 'sqlite3', '~> 1.3.3'
  # spec.add_development_dependency 'pg', '~> 0.21'
  # spec.add_development_dependency 'mysql2', '0.3.20'

end
