class StyleguidesController < Admin::Base
  before_filter :requires_staff!
  helper_method :styleguide_options
  helper_method :styleguide_title
  helper_method :styleguide_sections
  helper_method :styleguide_root

  before_filter :set_styleguide, :only => [ :show, :all]


  def show
    name = params[:section]
    @section = name.to_i

    #backward compatibility
    begin
      render template: "styleguides/#{name}", layout: 'styleguide_page'
    rescue
      render template: "styleguides/#{name.match(/^\d+/).to_s.to_i}", layout: 'styleguide_page'
    end
  end

  def index
    redirect_to nkss.root_url + "1"
  end

  def all
    @sections = styleguide_sections
    @sub = styleguide_sub
    @single_page = true
    render template: "styleguides/all", layout: 'styleguide_page'
  end

  def plain_file
    render js: File.read(File.join Rails.root, "#{params[:file]}")
  end

  def compiled_file
    render file: params[:file].gsub(/^\//,'')
  end

private

  def set_styleguide
    require 'kss'
    @styleguide = Kss::Parser.new(styleguide_root)
  end

  def styleguide_options
    @styleguide_options ||= YAML::load_file("#{Rails.root}/config/styleguides.yml")
  end

  def styleguide_title
    styleguide_options['title']
  end

  def styleguide_sections
    styleguide_options['sections']
  end

  def styleguide_sub
    styleguide_options['sub']
  end

  def styleguide_root
    path = styleguide_options['root'] || '/app/assets/stylesheets'
    File.join Rails.root, path
  end

end
