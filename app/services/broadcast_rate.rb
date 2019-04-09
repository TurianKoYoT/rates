class BroadcastRate
  attr_reader :rate

  def initialize(rate)
    @rate = rate
  end

  def broadcast
    ActionCable.server.broadcast(
      'rates',
      id: rate.id,
      html: html_to_render,
    )
  end

  def html_to_render
    ApplicationController.render(
      partial: 'rates/rate_widget',
      locals: { rate: rate },
    )
  end
end
