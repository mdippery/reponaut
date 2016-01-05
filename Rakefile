lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reponaut/version'

GEMSPEC = `git ls-files | grep gemspec`.chomp
GEM     = "reponaut-#{Reponaut::VERSION}.gem"

desc "Build reponaut.gem"
task :build => :perms do
  system "gem", "build", GEMSPEC
end

desc "Ensure correct permissions for reponaut.gem"
task :perms do
  system "chmod", "-R", "a+rX", *`git ls-files`.chomp.split("\n")
end

desc "Tag the latest version of reponaut"
task :tag do
  system "git", "tag", "-s", "-m", "reponaut v#{Reponaut::VERSION}", "v#{Reponaut::VERSION}"
end

desc "Install reponaut.gem"
task :install => :build do
  system "gem", "install", GEM
end

desc "Push gem to RubyGems"
task :release => [:tag, :build] do
  fail 'Cannot release a dev version' if Reponaut::VERSION.end_with?('dev')
  system "gem", "push", GEM
end

desc "Clean built products"
task :clean do
  rm Dir.glob("*.gem"), :verbose => true
end

task :default => :build
