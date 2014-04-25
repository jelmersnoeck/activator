require 'spec_helper'

describe Activator do
  context 'with `act_as_activator`' do
    it 'finds the active items' do
      Project.create(active: false)
      project = Project.create(active: true)

      Project.active.should eq project
    end

    it 'deactivates old items when creating new active ones' do
      project1 = Project.create(active: true)
      project1.active?.should be_true

      project2 = Project.create(active: true)
      project2.active?.should be_true
      project1.reload.active?.should be_false
    end

    it 'deactivates other items when setting another item to active' do
      project1 = Project.create(active: false)
      project2 = Project.create(active: true)

      project1.active?.should be_false
      project2.active?.should be_true

      project1.update_attributes(active: true)

      project1.reload.active?.should be_true
      project2.reload.active?.should be_false
    end
  end

  context 'without `act_as_activator`' do
    it 'shouldnt have an active class method if its not an activator' do
      expect { User.active }.to raise_error NoMethodError
    end

    it 'shouldnt have deactivation methods if not an activator' do
      user = User.create

      expect { user.deactivate }.to raise_error NoMethodError
      expect { user.deactivate_others }.to raise_error NoMethodError
    end
  end
end
