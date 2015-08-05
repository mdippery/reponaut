lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reponaut/version'

GEMSPEC = `git ls-files | grep gemspec`.chomp
GEM     = "reponaut-#{Reponaut::VERSION}.gem"

desc "Build reponaut.gem"
task :build do
  system "gem", "build", GEMSPEC
end

desc "Install reponaut.gem"
task :install => :build do
  system "gem", "install", GEM
end

desc "Push gem to RubyGems"
task :release => :build do
  system "git", "tag", "-s", "-m", "reponaut v#{Reponaut::VERSION}", "v#{Reponaut::VERSION}"
  system "gem", "push", GEM
end

desc "Clean built products"
task :clean do
  rm Dir.glob("*.gem"), :verbose => true
end

task :default => :build
