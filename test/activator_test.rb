require 'test_helper'

class ActivatorTest < ActiveSupport::TestCase
  test 'it can find the active items' do
    Project.create(active: false)
    project = Project.create(active: true)

    assert_equal project, Project.active
  end

  test 'it deactivates old items when creating new active ones' do
    project1 = Project.create(active: true)
    assert project1.active?

    project2 = Project.create(active: true)
    assert project2.active?
    refute project1.reload.active?
  end

  test 'it deactivates other items when setting another item to active' do
    project1 = Project.create(active: false)
    project2 = Project.create(active: true)

    refute project1.active?
    assert project2.active?

    project1.update_attributes(active: true)

    assert project1.reload.active?
    refute project2.reload.active?
  end

  test 'it shouldnt have an active class method if its not an activator' do
    assert_raise NoMethodError do
      User.active
    end
  end

  test 'it shouldnt have deactivation methods if not an activator' do
    user = User.create

    assert_raise NoMethodError do
      user.deactivate
    end

    assert_raise NoMethodError do
      user.deactivate_others
    end
  end
end
