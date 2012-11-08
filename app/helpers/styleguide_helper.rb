# # Nkss: Helpers
# A bunch of helpers you can use in your styleguides.

module StyleguideHelper

  class JSFile
    attr_accessor :path, :name, :exists
    def initialize(name)
      if name.present?
        @path = "/app/assets/javascripts/#{name}"
        @name = name.split('/').last
        @exists = true
      else
        @exists = false
      end
    end
  end

  # ### kss_block
  # Documents a styleguide block.
  #
  # Some options you can specify:
  #
  #  * `background` - The background color. Can be *clear*, *white*, *black*,
  #  *light*, or *dark*.
  #
  #  * `align` - Text alignment. Can be *left*, *right*, or *center*.
  #
  #  * `width` - (Optional) width for the inner area. Specify this for
  #  documenting long things.
  #
  # Example:
  #
  #     = kss_block '1.1' do
  #       %div.foo
  #         Put markup here!
  #
  # Example with options:
  #
  #     = kss_block '1.1', background: 'dark' do
  #
  def kss_block(section_id, options={}, &block)
    section = @styleguide.section(section_id)

    raise "Section '#{section_id}' not found."  unless section.filename

    example_html = capture(&block)

    defaults = { background: 'light', align: 'left', code: 'true' }
    options = defaults.merge(options)

    bg = "bg-#{options[:background]}"
    align = "align-#{options[:align]}"
    classes = [bg, align]

    inner_style = ''
    inner_style = "width: #{options[:width]}px; margin: 0 auto"  if options[:width]

    render \
      partial: 'styleguides/block',
      locals: {
        canvas_class: classes.join(' '),
        code_block: block,
        html: example_html,
        section: section,
        modifiers: (section.modifiers rescue Array.new),
        options: options,
        inner_style: inner_style,
      }
  end

  def describe(&block)
    @description = capture(@file, &block)
      if @file.exists
        desc = link_to(  "plain: #{@file.name}", "plain_file:#{@file.path}")
        desc << link_to( "compiled: #{@file.path}", "compiled_file:#{@file.path}")
      else
        desc = ""
      end
    @description << content_tag(:div, desc, class: 'sg-file-description')
  end

  def code(file = nil, &block)
    if file.present?
      @code = File.read(File.join Rails.root, "#{file}")
    else
      @code = capture(&block)
    end
    @code = content_tag(:div, ::Pygments.highlight(@code, lexer: @lexer, linenos: 'table').html_safe, class: 'sg-canvas bg-clear')
    content_tag(:div, @code, class: 'sg-canvases')
  end

  def text(&block)
    @code = capture(&block)
    @code = content_tag(:div, @code, class: 'sg-description')
  end

  def kss_code(section_id, options={}, &block)
    @file = JSFile.new(options[:filename])
    @description = content_tag :h1, options[:filename]
    require "pygments"
    @lexer = options.fetch(:lexer, 'coffeescript')
    render partial: 'styleguides/code', locals: {section: section_id, options: options, rest: capture(@file, &block)}
  end

  # ### kss_specimen
  # Renders a type specimen. This is great for demoing fonts.
  # Use it like so:
  #
  #     = kss_block '2.1' do
  #       .proxima-nova
  #         = kss_specimen
  #
  # This gets you a `<div class='sg-specimen'>` block which has already been
  # styled to showcase different sizes of the given font.

  def kss_specimen
    render partial: 'styleguides/specimen'
  end

  # ### kss_swatch
  # Renders a type specimen. This is great for demoing colors.
  #
  #     = kss_block '2.1' do
  #       = kss_swatch 'red', '#ff3322', description: 'for error text'

  def kss_swatch(name, color, options={})
    render partial: 'styleguides/swatch', locals: {
      name: name,
      identifier: name,
      color: color,
      dark: options[:dark],
      description: options[:description]
    }
  end

  # ### lorem
  # Convenient lorem ipsum helper.
  #
  # Yeah, well, you'll need this for a lot of styleguide sections. Use it like
  # so:
  #
  #     %p= lorem.paragraph
  #     %li= lorem.sentence
  #
  def lorem
    require 'ffaker'

    Faker::Lorem
  end

  # ### markdown
  # Markdownify some text.

  def markdown(text)
    require 'bluecloth'

    str = BlueCloth.new(text).to_html
    str = str.html_safe  if str.respond_to?(:html_safe)
    str
  end

end
