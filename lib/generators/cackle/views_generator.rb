class Cackle::ViewsGenerator < Rails::Generators::Base
  require 'rails/generators/base'
  
  public_task :copy_views
  source_root File.expand_path('../../../app/views', __FILE__)
  
  def copy_views
    directory 'cackle', 'app/views/cackle'
  end
end