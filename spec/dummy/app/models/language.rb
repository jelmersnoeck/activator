class Language < ActiveRecord::Base
  include Activator

  activator_field :default
end
