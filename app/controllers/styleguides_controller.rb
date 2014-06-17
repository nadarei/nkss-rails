class StyleguidesController < ApplicationController

  helper :styleguide

  helper_method :styleguide_options
  helper_method :styleguide_title
  helper_method :styleguide_sections
  helper_method :styleguide_root

  before_filter :set_styleguide, :only => [ :show, :all ]

  def show
    @section = params[:section].to_i

    render template: "styleguides/#{@section}", layout: 'styleguide_page'
  end

  def index
    redirect_to nkss.root_url + "1"
  end

  def all
    @sections = styleguide_sections
    @single_page = true
    render template: "styleguides/all", layout: 'styleguide_page'
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

  def styleguide_root
    path = styleguide_options['root'] || '/app/assets/stylesheets'
    File.join Rails.root, path
  end
end
