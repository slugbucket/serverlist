require 'test_helper'

class DbScheduledJobsControllerTest < ActionController::TestCase
  setup do
    @db_scheduled_job = db_scheduled_jobs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:db_scheduled_jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create db_scheduled_job" do
    assert_difference('DbScheduledJob.count') do
      post :create, db_scheduled_job: { application_id: @db_scheduled_job.application_id, db_instance_db_name: @db_scheduled_job.db_instance_db_name, db_job_freq: @db_scheduled_job.db_job_freq, db_job_host: @db_scheduled_job.db_job_host, db_job_owner: @db_scheduled_job.db_job_owner, db_job_status: @db_scheduled_job.db_job_status, db_job_type: @db_scheduled_job.db_job_type, description: @db_scheduled_job.description, name: @db_scheduled_job.name }
    end

    assert_redirected_to db_scheduled_job_path(assigns(:db_scheduled_job))
  end

  test "should show db_scheduled_job" do
    get :show, id: @db_scheduled_job
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @db_scheduled_job
    assert_response :success
  end

  test "should update db_scheduled_job" do
    patch :update, id: @db_scheduled_job, db_scheduled_job: { application_id: @db_scheduled_job.application_id, db_instance_db_name: @db_scheduled_job.db_instance_db_name, db_job_freq: @db_scheduled_job.db_job_freq, db_job_host: @db_scheduled_job.db_job_host, db_job_owner: @db_scheduled_job.db_job_owner, db_job_status: @db_scheduled_job.db_job_status, db_job_type: @db_scheduled_job.db_job_type, description: @db_scheduled_job.description, name: @db_scheduled_job.name }
    assert_redirected_to db_scheduled_job_path(assigns(:db_scheduled_job))
  end

  test "should destroy db_scheduled_job" do
    assert_difference('DbScheduledJob.count', -1) do
      delete :destroy, id: @db_scheduled_job
    end

    assert_redirected_to db_scheduled_jobs_path
  end
end
