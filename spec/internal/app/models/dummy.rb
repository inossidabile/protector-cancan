class Dummy < ActiveRecord::Base
  protect do |user|
    can :view
    can :create
    can :update
    can :destroy
    can :test
  end

  belongs_to :user
end