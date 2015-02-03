require 'spec_helper'

describe Activator do
  context 'without a field given' do
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

  context 'with a custom activator field' do
    context '#activator_field' do
      subject do
        Language.new
      end

      it 'should have :default as activator field' do
        subject.send(:activator_field).should eq :default
      end
    end

    context '#default' do
      it 'should create a class method #default to get the default langauge' do
        Language.create(default: false)
        language = Language.create(default: true)

        Language.default.should eq language
      end

      it "should respond to the default method" do
        Language.respond_to?(:default).should be true
      end
    end

    context 'overwriting defaults' do
      it 'should update old values when creating a new default item' do
        language1 = Language.create(default: true)
        language2 = Language.create(default: true)

        language1.reload.default?.should be_false
        language2.reload.default?.should be_true
      end

      it 'should deactivate others when updating' do
        language1 = Language.create(default: false)
        language2 = Language.create(default: true)

        language1.update_attributes(default: true)

        language1.reload.default?.should be_true
        language2.reload.default?.should be_false
      end
    end
  end

end
