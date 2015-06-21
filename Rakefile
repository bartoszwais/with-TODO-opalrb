require 'opal'
require 'opal-jquery'

desc "Build our app to build.js"
task :build do
  Opal.append_path "app"
  compiler_output = Opal::Builder.build("application").to_s
  File.binwrite "build.js", compiler_output
end
