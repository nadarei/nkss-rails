require 'rails/generators/base'

module Nkss
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)
    desc 'Nkss Rails Install'

    def install_steps
      copy_file '1.html.haml', 'app/views/styleguides/1.html.haml'
      copy_file 'styleguides.yml', 'config/styleguides.yml'
      copy_file 'styleguide-extras.css', 'app/assets/stylesheets/styleguide-extras.css'
      copy_file 'example-for-styleguides.css', 'app/assets/stylesheets/example-for-styleguides.css'
      copy_file 'styleguide.html.haml', 'app/views/layouts/styleguide.html.haml'

      route "mount Nkss::Engine => '/styleguides' if Rails.env.development?"
    end
  end
end
