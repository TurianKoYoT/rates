class UpdateRatesData
  DATA_URL = 'https://www.cbr-xml-daily.ru/daily_json.js'.freeze

  class << self
    def update
      data = RestClient.get(DATA_URL)
      parsed_values_data = JSON.parse(data)['Valute']

      rates = Rate.all

      rates.each do |rate|
        BroadcastRate.new(rate).broadcast if rate.update!(value: parsed_values_data[rate.code]['Value'])
      end
    end
  end
end
