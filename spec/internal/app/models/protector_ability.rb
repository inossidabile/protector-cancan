class ProtectorAbility
  include CanCan::Ability

  def initialize(user)
    import_protector user
  end
end