task default: %w(lint test)

task :lint do
  Rake::Task[:lint_task].invoke('')
end

task :lintall do
  Rake::Task[:lint_task].invoke('-c /dev/null')
end

task :test do
  sh 'cd src && rspec -c'
  sh 'cd utils && rspec -c'
end

task :lint_task, [:params] do |_, params|
  sh 'ruby -w -c */*.rb'
  sh "rubocop -DE #{params.first[1]}"
end
