# train-ticket
Sample app for Nishiwaki.rb &amp; Kobe.rb

Question is here:

[チケット・改札機問題](https://gist.github.com/JunichiIto/39caae4f1c90499e2239785c3faf1b75)

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
