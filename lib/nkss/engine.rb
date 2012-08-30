module Nkss
  class Engine < Rails::Engine
    # Same as doing `mount Nkss::Engine => '/stylesheets', as: :nkss`
    engine_name :nkss
  end
end
