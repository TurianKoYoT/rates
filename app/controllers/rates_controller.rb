class RatesController < ApplicationController
  def index
    @rates = Rate.all
  end

  def update
    rate = Rate.find(params[:id])

    old_value = rate.value

    rate.update!(
      value: params[:rate][:forced_value],
      forced_value: params[:rate][:forced_value],
      forced_until: params[:rate][:forced_until],
    )

    BroadcastRate.new(rate).broadcast
    ChangeValueToNormalWorker.perform_at(rate.forced_until, rate.id, old_value)
  end
end
