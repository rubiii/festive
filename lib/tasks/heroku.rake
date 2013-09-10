namespace :heroku do

  # Hack to install NPM dependencies on Heroku's Ruby/Rails setup.
  # https://github.com/heroku/heroku-buildpack-ruby/issues/67
  task :install_js_deps do
    system '(cd /tmp && curl -O https://heroku-buildpack-nodejs.s3.amazonaws.com/nodejs-0.8.19.tgz)'
    system '(mkdir -p bin/nodejs && cd bin/nodejs && tar xzf /tmp/nodejs-0.8.19.tgz)'
    system 'bin/nodejs/bin/node bin/nodejs/bin/npm install'
    system 'node_modules/.bin/bower install'
  end

end

task 'assets:precompile' => 'heroku:install_js_deps'