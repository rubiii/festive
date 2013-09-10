# Festive

[![Build Status](https://secure.travis-ci.org/rubiii/festive.png)](http://travis-ci.org/rubiii/festive)

Sample application for importing and displaying the
"[Berliner und Brandenburger Volks- und Straßenfeste 2013](http://daten.berlin.de/datensaetze/berliner-und-brandenburger-volks-und-stra%C3%9Fenfeste-2013)" (fairs and festivals in Berlin and Brandenburg, Germany).


## Setup

Prerequisites:

* Ruby 2.0 (+Bundler)
* Node/NPM

Clone and setup the project:

``` shell
git clone git@github.com:rubiii/festive.git
cd festive
bin/setup
```


## Web

The web application is based on Ruby on Rails 4.0. Start the application:

``` shell
bundle exec foreman start
```


## Import

The import is a simple Ruby script that can be started as a Rake task:

``` shell
bundle exec rake workers:import
```

This imports or updates all data from the public JSON API.


## Tests

To run the Ruby tests:

``` shell
bundle exec rake test
```

JavaScript tests are running on Karma:

``` shell
bundle exec rake karma
```
