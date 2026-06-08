require "test_helper"

class FraudCheckJobTest < ActiveJob::TestCase
  test "job can be enqueued" do
    assert_enqueued_jobs 0
    FraudCheckJob.perform_later(clicks(:one))
    assert_enqueued_jobs 1
  end

  test "job can be performed immediately" do
    assert_nothing_raised do
      FraudCheckJob.perform_now(clicks(:one))
    end
  end

  test "job is queued on the default queue" do
    job = FraudCheckJob.perform_later(clicks(:one))
    assert_equal "default", job.queue_name
  end

  test "job serializes the click argument" do
    click = clicks(:one)
    job = FraudCheckJob.perform_later(click)
    assert_equal click, job.arguments.first
  end
end
