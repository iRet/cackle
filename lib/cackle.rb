module Cackle
  require "cackle/railtie" if defined?(Rails)
  require 'app/helpers/cackle_helper'

  ActionView::Base.send :include, CackleHelper

  path = File.join(File.dirname(__FILE__), 'app', 'models')
  $LOAD_PATH << path
  ActiveSupport::Dependencies.autoload_paths << path
  ActiveSupport::Dependencies.autoload_once_paths.delete(path)
  
  ActionController::Base.prepend_view_path File.join(File.dirname(__FILE__), 'app/views')
end
