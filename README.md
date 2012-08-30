Nadarei KSS
===========

**Nadarei KSS Styleguides** lets you create pretty styleguides for your Rails
3.2 projects.

![Image](https://raw.github.com/nadarei/nkss-rails/misc/sample.jpg)

What is KSS?
------------

It's a standard for documenting stylesheets. It's also a tool that parses these
sheets, which `nkss-rails` uses.

See the KSS website at [warpspire.com/kss](http://warpspire.com/kss).

### What is nkss-rails?

A drop-in, easy-to-use, gorgeous-by-default Rails plugin you can put into your
projects so you can instantly have cute docs.

It's a pre-configured distribution of KSS. I've already done the grunt work for
you, like setting up the layouts, templates and CSS files for your styleguide.
All you gotta worry about is documenting your styles!

Installation
------------

Add me, and `haml`, to your `Gemfile`.

    gem 'haml'
    gem 'nkss-rails', github: 'nadarei/nkss-rails'

Then type `bundle` to update your bundle. Then, install the needed files into
your project:

    $ bundle exec rails generate nkss:install

Now move on to the next section.

### Customization

This gives you the following things that you should customize:

#### `config/styleguides.yml`

 A list of sections in your styleguide. Your
 mission: edit this file to add your own sections.

#### `app/views/styleguides/`

 Your styleguides live here. Your mission:
 edit the first styleguide (*1.html.haml*) and later, add your own.

#### `app/views/layouts/styleguide.html.haml`

 The layout for your styleguide. Your mission: make sure that this loads the
 right styles and scripts that your
 application uses.

#### `app/assets/stylesheets/styleguide-extras.css`

 Place any extra CSS definitions in here.

#### `app/assets/stylesheets/example-for-styleguides.css`
 An example of a documented KSS block. Study it, then delete it.

### Viewing your sheets

Now visit `http://localhost:8000/styleguides`. It should work straight away. By
default, it's only enabled in development mode.

This works because you have a new route added to your app that mounts the Nkss
engine to that path:

    Rails.application.routes.draw do
      ...
      mount Nkss::Engine => '/styleguides'  if Rails.env.development?
      ...
    end

How to document your styles
---------------------------

When you do the process above, you should already have an example in
`app/assets/stylesheets/example-for-styleguides.css`. But here's how to do it,
anyway...

### Document your CSS

In your CSS file, add a KSS document block. In this example, we'll define
section `1.3`. Refer to the [KSS Syntax](http://warpspire.com/kss/syntax/) page 
for more info.

    /*
    A button for doing things.
    
    Styleguide 1.3.
    */
    .button {
      color: red
    }

### Add the markup

Add the markup in the corresponding section in
`app/views/styleguides/N.html.haml`, where `N` is the main section number. In
this case, we'll be editing `1.html.haml`.

    -# 1.html.haml
    = kss_block '1.3' do
      %a.button{href: '#'} Do things

### For new main sections

If you're adding a new main section, edit the file `config/styleguides.yml` to
add it to the menu.

    # config/styleguides.yml
    title: My Site
    sections:
      1: Buttons
      2: Forms
      3: Ratings
      4: ...

### That's it!

You should see your newly-documented style in
`http://localhost:8000/styleguides/1`.

Using in production
-------------------

Just make sure to add `styleguide.css` and `styleguide-extras.css` to your
precompilation list. Usually this is in `config/environments/production.rb`.

Our bias
--------

We use this happily with our client projects, and our clients are happy with it,
too. It has quite a bias with our process (for instance: HAML by default), sorry
about that.

Our primary purpose of maintaining this package is to use it for our projects;
as such, we can't always guarantee that all contributions will be merged in.

If you feel this is too limiting, you can always override the
[templates](https://github.com/nadarei/nkss-rails/tree/master/app/views)
or 
[CSS](https://github.com/nadarei/nkss-rails/tree/master/app/assets/stylesheets)
by copying them to your application.

Alternatively, simply copy the entire gem to your project and hack away at it
yourself:

    $ git clone https://github.com/nadarei/nkss-rails.git ./vendor/nkss-rails
    
    # In your gemfile:
    gem 'nkss-rails', path: 'vendor/nkss-rails'

Acknowledgements
----------------

2012, MIT License.
