namespace :workers do

  desc 'Import events from source'
  task :import => :environment do
    ImportWorker.new.run
  end

end
