# nkss-rails: Nadarei KSS Styleguides for Rails

![Image](https://raw.github.com/nadarei/nkss-rails/misc/sample.jpg)

What is KSS?
------------

It's a standard for documenting stylesheets. It's also a tool that parses these
sheets, which `nkss-rails` uses.

See the website: http://warpspire.com/kss

What is nkss-rails?
-------------------

A drop-in, easy-to-use, gorgeous-by-default Rails engine you can put into your
projects so you can instantly have cute docs.

Installation
------------

Add me to your `Gemfile`.

``` ruby
gem 'nkss-rails', github: 'nadarei/nkss-rails'
```

Install my files.

```
$ rails generate nkss:install
```

Now move on to the next section.

Customization
-------------

This gives you the following things that you should customize:

 * `config/styleguides.yml` - a list of sections in your styleguide. Your
 mission: edit this file to add your own sections.

 * `app/views/styleguides/` - a repository of your styleguides. Your mission:
 edit the first styleguide (*1.html.haml*) and later, add your own.

 * `app/views/layouts/styleguide.html.haml` - the layout for your styleguide.
 Your mission: make sure that this loads the right styles and scripts that your
 application uses.

 * `app/assets/stylesheets/styleguide-extras.css` - Place any extra CSS
 definitions in here.

Also you'll have:

 * `app/assets/stylesheets/example-for-styleguides.css` - An example of a
 documented KSS block. Study it, then delete it.

Viewing your sheets
-------------------

Now visit `http://localhost:8000/styleguides`. It should work straight away. By
default, it's only enabled in development mode.

This works because you have a new route added to your app that mounts the Nkss
engine to that path:

``` ruby
Rails.application.routes.draw do
  ...

  mount Nkss::Engine => '/styleguides'  if Rails.env.development?

  ...
end
```

Using in production
-------------------

Just make sure to add `styleguide.css` and `styleguide-extras.css` to your
precompilation list. Usually this is in `config/environments/production.rb`.

Acknowledgements
----------------

2012, MIT License.
