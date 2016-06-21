
Gem::Specification.new do |spec|
  spec.name          = "embulk-filter-script_ruby"
  spec.version       = "0.1.0"
  spec.authors       = ["shinjiikeda"]
  spec.summary       = "Script Ruby filter plugin for Embulk"
  spec.description   = "Script Ruby"
  spec.email         = ["gm.ikeda@gmail.com"]
  spec.licenses      = ["MIT"]
  spec.homepage      = "https://github.com/shinjiikeda/embulk-filter-script_ruby"

  spec.files         = `git ls-files`.split("\n") + Dir["classpath/*.jar"]
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ["lib"]

  #spec.add_dependency 'YOUR_GEM_DEPENDENCY', ['~> YOUR_GEM_DEPENDENCY_VERSION']
  spec.add_development_dependency 'embulk', ['>= 0.8.9']
  spec.add_development_dependency 'bundler', ['>= 1.10.6']
  spec.add_development_dependency 'rake', ['>= 10.0']
end
