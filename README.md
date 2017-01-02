# train-ticket
Sample app for Nishiwaki.rb &amp; Kobe.rb

## Generate API document

```
gem install yard
yardoc lib/*.rb && open ./doc/index.html
```

## How to run tests

Set up libraries:

```
gem install bundler
bundle install
```

Run tests:

```
bundle exec rspec
```