require 'test_helper'

class SignupsControllerTest < ActionController::TestCase
  setup do
    @signup = signups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:signups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create signup" do
    assert_difference('Signup.count') do
      post :create, signup: { game_id: @signup.game_id, nation_id: @signup.nation_id, password: @signup.password, status: @signup.status, turn: @signup.turn, user_id: @signup.user_id }
    end

    assert_redirected_to signup_path(assigns(:signup))
  end

  test "should show signup" do
    get :show, id: @signup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @signup
    assert_response :success
  end

  test "should update signup" do
    put :update, id: @signup, signup: { game_id: @signup.game_id, nation_id: @signup.nation_id, password: @signup.password, status: @signup.status, turn: @signup.turn, user_id: @signup.user_id }
    assert_redirected_to signup_path(assigns(:signup))
  end

  test "should destroy signup" do
    assert_difference('Signup.count', -1) do
      delete :destroy, id: @signup
    end

    assert_redirected_to signups_path
  end
end
