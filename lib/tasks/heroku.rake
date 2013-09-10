namespace :heroku do

  # Hack to install NPM dependencies on Heroku's Ruby/Rails setup.
  # https://github.com/heroku/heroku-buildpack-ruby/issues/67
  task :install_js_deps do
    buildpack = 'http://heroku-buildpack-nodejs.s3.amazonaws.com/nodejs-0.10.3.tgz'

    system "(mkdir -p bin/nodejs && cd bin/nodejs && curl #{buildpack} -s -o - | tar xzf -)"
    system 'cd bin/nodejs && bin/node bin/npm install'
    system 'node_modules/.bin/bower install'
  end

end

task 'assets:precompile' => 'heroku:install_js_deps'
