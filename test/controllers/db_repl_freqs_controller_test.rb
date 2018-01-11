require 'test_helper'

class DbReplFreqsControllerTest < ActionController::TestCase
  setup do
    @db_repl_freq = db_repl_freqs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:db_repl_freqs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create db_repl_freq" do
    assert_difference('DbReplFreq.count') do
      post :create, db_repl_freq: { name: @db_repl_freq.name }
    end

    assert_redirected_to db_repl_freq_path(assigns(:db_repl_freq))
  end

  test "should show db_repl_freq" do
    get :show, id: @db_repl_freq
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @db_repl_freq
    assert_response :success
  end

  test "should update db_repl_freq" do
    patch :update, id: @db_repl_freq, db_repl_freq: { name: @db_repl_freq.name }
    assert_redirected_to db_repl_freq_path(assigns(:db_repl_freq))
  end

  test "should destroy db_repl_freq" do
    assert_difference('DbReplFreq.count', -1) do
      delete :destroy, id: @db_repl_freq
    end

    assert_redirected_to db_repl_freqs_path
  end
end
