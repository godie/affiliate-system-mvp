require "test_helper"

class AttributionJobTest < ActiveJob::TestCase
  test "job can be enqueued" do
    assert_enqueued_jobs 0
    AttributionJob.perform_later(conversions(:one))
    assert_enqueued_jobs 1
  end

  test "job can be performed immediately" do
    assert_nothing_raised do
      AttributionJob.perform_now(conversions(:one))
    end
  end

  test "job is queued on the default queue" do
    job = AttributionJob.perform_later(conversions(:one))
    assert_equal "default", job.queue_name
  end

  test "job serializes the conversion argument" do
    conversion = conversions(:one)
    job = AttributionJob.perform_later(conversion)
    assert_equal conversion, job.arguments.first
  end
end
