require 'spec_helpers/boot'

describe Protector::CanCan::Ability do
  let(:_Model) do
    Class.new(ActiveRecord::Base) do
      self.table_name = 'dummies'
    end
  end

  let(:_Ability) do
    Class.new do
      include CanCan::Ability
    end
  end

  it "defaults properly" do
    _Ability.new.protector_subject?.should == false
  end

  it "initializes properly" do
    _Ability.class_eval do
      def initialize(user)
        import_protector user
      end
    end

    ability = _Ability.new('user')

    ability.protector_subject?.should == true
    ability.protector_subject.should == 'user'
    ability.can?(:read, _Model).should == false
    ability.can?(:create, _Model).should == false
    ability.can?(:update, _Model).should == false
    ability.can?(:destroy, _Model).should == false
  end

  it "proxies rules" do
    _Ability.class_eval do
      def initialize(user)
        import_protector user
      end
    end

    _Model.class_eval do
      protect do |user|
        can :view
        can :create
        can :update
        can :destroy
        can :test
      end
    end

    ability = _Ability.new('user')

    ability.protector_subject?.should == true
    ability.protector_subject.should == 'user'
    ability.can?(:read, _Model).should == true
    ability.can?(:create, _Model).should == true
    ability.can?(:update, _Model).should == true
    ability.can?(:destroy, _Model).should == true
    ability.can?(:test, _Model).should == true
  end
end