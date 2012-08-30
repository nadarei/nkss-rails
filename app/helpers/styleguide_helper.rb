module StyleguideHelper

  def kss_block(section_id, options={}, &block)
    section = @styleguide.section(section_id)

    raise "Section '#{section_id}' not found."  unless section.filename

    example_html = capture(&block)

    defaults = { background: 'light', align: 'left' }
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
