require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  setup do
    @player = players(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:players)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create player" do
    assert_difference('Player.count') do
      post :create, player: { aim: @player.aim, avatar: @player.avatar, email_pref: @player.email_pref, forum_id: @player.forum_id, googletalk: @player.googletalk, icq: @player.icq, msn_messenger: @player.msn_messenger, other: @player.other, steam: @player.steam, timezone: @player.timezone, user_id: @player.user_id, xfire: @player.xfire, yahoo_messenger: @player.yahoo_messenger }
    end

    assert_redirected_to player_path(assigns(:player))
  end

  test "should show player" do
    get :show, id: @player
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @player
    assert_response :success
  end

  test "should update player" do
    put :update, id: @player, player: { aim: @player.aim, avatar: @player.avatar, email_pref: @player.email_pref, forum_id: @player.forum_id, googletalk: @player.googletalk, icq: @player.icq, msn_messenger: @player.msn_messenger, other: @player.other, steam: @player.steam, timezone: @player.timezone, user_id: @player.user_id, xfire: @player.xfire, yahoo_messenger: @player.yahoo_messenger }
    assert_redirected_to player_path(assigns(:player))
  end

  test "should destroy player" do
    assert_difference('Player.count', -1) do
      delete :destroy, id: @player
    end

    assert_redirected_to players_path
  end
end
