require_relative 'lib/base_conversions/version'

Gem::Specification.new do |spec|
  spec.name          = "base_conversions"
  spec.version       = "0.1.0"
  spec.authors       = ["Daniel Schierbeck"]
  spec.email         = ["daniel@dasch.io"]

  spec.summary       = "Convert between base16 and base32"
  spec.description   = "Convert between base16 and base32."
  spec.homepage      = "https://github.com/dasch/base_conversions"
  spec.license       = "Apache 2.0"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
