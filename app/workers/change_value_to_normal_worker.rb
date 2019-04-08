class ChangeValueToNormalWorker
  include Sidekiq::Worker

  def perform(rate_id, old_value)
    rate = Rate.find(rate_id)

    rate.update!(
      value: old_value,
    )

    BroadcastRate.new(rate).broadcast
  end
end
