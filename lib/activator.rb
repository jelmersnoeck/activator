module Activator
  extend ActiveSupport::Concern

  included do
    after_save :deactivate_others
  end

  module ClassMethods
    @@used_activator_field = :active

    def activator_field(name)
      @@used_activator_field = name
    end

    define_method(@@used_activator_field.to_sym) do ||
      find_by("#{@@used_activator_field} = ?", true)
    end
  end

  def deactivate!
    self.update_attributes(active: false)
  end

  def deactivate_others
    return unless self.active?
    self.class.where('id <> :id', id: self.id).where(active: true).
      map(&:deactivate!)
  end
end
