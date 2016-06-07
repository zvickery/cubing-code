task default: %w(test)

task :lint do
  sh 'ruby -c */*.rb'
  sh 'rubocop'
end

task :test do
  sh 'cd src && rspec -c'
  sh 'cd utils && rspec -c'
end
