class DummiesController < ActionController::Base
  before_filter(only: :test) do
    @dummies = Dummy.restrict!('test')
  end

  load_and_authorize_resource

  def index
    render nothing: true
  end

  def show
    render nothing: true
  end

  def create
    render nothing: true
  end

  def edit
    render nothing: true
  end

  def update
    render nothing: true
  end

  def destroy
    render nothing: true
  end

  def test
    render nothing: true
  end

  protected

    def current_user
      'user'
    end

    def current_ability
      ability = params[:protector] ? ProtectorAbility : DefaultAbility
      @current_ability ||= ability.new(current_user)
    end
end