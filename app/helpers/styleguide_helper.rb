# # Nkss: Helpers
# A bunch of helpers you can use in your styleguides.

module StyleguideHelper

  # ### kss_block
  # Documents a styleguide block.
  #
  #     = kss_block '1.1' do
  #
  # Some options you can specify:
  #
  #  * `background` - The background color. Can be *clear*, *white*, *black*,
  #  *light*, or *dark*.
  #
  #  * `align` - Text alignment. Can be *left*, *right*, or *center*.
  #
  #  * `code` - (Boolean) shows the code if *true*, hides if *false*. Defaults to *true*.
  #
  # Example:
  #
  #     = kss_block '1.1', background: 'dark' do
  #
  def kss_block(section_id, options={}, &block)
    section = @styleguide.section(section_id)

    raise "Section '#{section_id}' not found."  unless section.filename

    example_html = capture(&block)

    defaults = { background: 'light', align: 'left', code: 'true' }
    options = defaults.merge(options)

    # Build the CSS classes
    bg = "bg-#{options[:background]}"
    align = "align-#{options[:align]}"
    classes = [bg, align]

    render \
      partial: 'styleguides/block',
      locals: {
        canvas_class: classes.join(' '),
        code_block: block,
        html: example_html,
        show_code: options[:code],
        section: section,
        modifiers: (section.modifiers rescue Array.new),
        options: options,
      }
  end

  # Renders a type specimen.
  def kss_specimen
    render partial: 'styleguides/specimen'
  end

  def markdown(text)
    require 'bluecloth'

    str = BlueCloth.new(text).to_html
    str = str.html_safe  if str.respond_to?(:html_safe)
    str
  end

  def h(text)
    CGI::escapeHTML text
  end

  def lorem
    require 'ffaker'

    Faker::Lorem
  end

end
