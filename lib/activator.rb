module Activator
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def act_as_activator
      # If we don't activate a field, we don't need a class method to find the
      # active elements.
      self.extend(ActivationMethods)
      self.send(:include, InstanceMethods)
      self.send(:after_save, :deactivate_others)
    end

    module ActivationMethods
      def active
        find_by(active: true)
      end
    end
  end

  module InstanceMethods
    def deactivate
      self.update_attributes(active: false)
    end

    def deactivate_others
      return unless self.active?
      self.class.where('id <> :id', id: self.id).where(active: true).
        map(&:deactivate)
    end
  end
end

ActiveRecord::Base.send :include, Activator
