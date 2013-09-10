namespace :test do

  desc "Test worker source"
  Rake::TestTask.new(:workers) do |t|
    t.libs << 'test'
    t.pattern = 'test/workers/**/*_test.rb'
    t.verbose = true
  end

end

Rake::Task[:test].enhance { Rake::Task['test:workers'].invoke }

desc "Test JavaScript source"
task :karma do
  system 'node_modules/.bin/karma start test/javascripts/karma.js.coffee'
end
