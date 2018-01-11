require 'test_helper'

class DbJobFreqsControllerTest < ActionController::TestCase
  setup do
    @db_job_freq = db_job_freqs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:db_job_freqs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create db_job_freq" do
    assert_difference('DbJobFreq.count') do
      post :create, db_job_freq: { name: @db_job_freq.name }
    end

    assert_redirected_to db_job_freq_path(assigns(:db_job_freq))
  end

  test "should show db_job_freq" do
    get :show, id: @db_job_freq
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @db_job_freq
    assert_response :success
  end

  test "should update db_job_freq" do
    patch :update, id: @db_job_freq, db_job_freq: { name: @db_job_freq.name }
    assert_redirected_to db_job_freq_path(assigns(:db_job_freq))
  end

  test "should destroy db_job_freq" do
    assert_difference('DbJobFreq.count', -1) do
      delete :destroy, id: @db_job_freq
    end

    assert_redirected_to db_job_freqs_path
  end
end
