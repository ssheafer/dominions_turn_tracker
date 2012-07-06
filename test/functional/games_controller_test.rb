require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    @game = games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, game: { era_cd: @game.era_cd, host_time: @game.host_time, last_poll: @game.last_poll, map_download: @game.map_download, map_preview: @game.map_preview, max_players: @game.max_players, message: @game.message, name: @game.name, players_remaining: @game.players_remaining, port: @game.port, provinces: @game.provinces, requires_passwords: @game.requires_passwords, server: @game.server, status_cd: @game.status_cd, timer: @game.timer, turn_number: @game.turn_number }
    end

    assert_redirected_to game_path(assigns(:game))
  end

  test "should show game" do
    get :show, id: @game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game
    assert_response :success
  end

  test "should update game" do
    put :update, id: @game, game: { era_cd: @game.era_cd, host_time: @game.host_time, last_poll: @game.last_poll, map_download: @game.map_download, map_preview: @game.map_preview, max_players: @game.max_players, message: @game.message, name: @game.name, players_remaining: @game.players_remaining, port: @game.port, provinces: @game.provinces, requires_passwords: @game.requires_passwords, server: @game.server, status_cd: @game.status_cd, timer: @game.timer, turn_number: @game.turn_number }
    assert_redirected_to game_path(assigns(:game))
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, id: @game
    end

    assert_redirected_to games_path
  end
end
