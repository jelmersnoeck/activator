module Activator
  extend ActiveSupport::Concern

  included do
    after_save :deactivate_others
  end

  module ClassMethods
    def active
      find_by(active: true)
    end
  end

  def deactivate
    self.update_attributes(active: false)
  end

  def deactivate_others
    return unless self.active?
    self.class.where('id <> :id', id: self.id).where(active: true).
      map(&:deactivate)
  end
end

ActiveRecord::Base.send :include, Activator
