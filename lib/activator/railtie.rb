module Activator
  class Railtie < Rails::Railtie
    initializer 'attached.initialize' do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :include, Activator
      end
    end
  end
end
