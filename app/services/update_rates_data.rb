class UpdateRatesData
  DATA_URL = 'https://www.cbr-xml-daily.ru/daily_json.js'.freeze

  class << self
    def update
      data = RestClient.get(DATA_URL)
      parsed_values_data = JSON.parse(data)['Valute']

      rates = Rate.all

      rates.each do |rate|
        broadcast(rate) if rate.update!(value: parsed_values_data[rate.code]['Value'])
      end
    end

    private

    def broadcast(rate)
      ActionCable.server.broadcast(
        'rates',
        id: rate.id,
        html: html_to_render(rate),
      )
    end

    def html_to_render(rate)
      ApplicationController.render(
        partial: 'rates/rate_widget',
        locals: { rate: rate },
      )
    end
  end
end
