module Activator
  extend ActiveSupport::Concern

  included do
    after_save :deactivate_others
    activator_field :active
  end

  module ClassMethods
    def activator_field(name)
      @used_activator_field = name.to_sym
    end

    def used_activator_field
      @used_activator_field
    end

    def method_missing(name, *args)
      if name == used_activator_field
        activator_search_item
      else
        super
      end
    end

    def respond_to?(name, include_private = false)
      if name == used_activator_field
        true
      else
        super
      end
    end

    private
    def activator_search_item
      find_by(:"#{used_activator_field}" => true)
    end
  end

  def activator_deactivate!
    self.update_attributes(:"#{activator_field}" => false)
  end

  private
  def deactivate_others
    return unless self.send("#{activator_field}?".to_sym)
    self.class.where('id <> :id', id: self.id).
      where(:"#{activator_field}" => true).
      map(&:activator_deactivate!)
  end

  def activator_field
    self.class.used_activator_field
  end
end
