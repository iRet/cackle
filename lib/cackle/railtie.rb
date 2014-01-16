module Cackle
  require 'rails'

  class Railtie < Rails::Railtie
    rake_tasks { load "tasks/cackle_tasks.rake" }
  end
end