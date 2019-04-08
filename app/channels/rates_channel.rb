class RatesChannel < ApplicationCable::Channel
  def follow
    stream_from 'rates'
  end
end
