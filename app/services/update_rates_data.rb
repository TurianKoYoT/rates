class UpdateRatesData
  DATA_URL = 'https://www.cbr-xml-daily.ru/daily_json.js'.freeze

  def self.update
    data = RestClient.get(DATA_URL)
    parsed_values_data = JSON.parse(data)['Valute']

    rates = Rate.all

    rates.each do |rate|
      rate.update!(value: parsed_values_data[rate.code]['Value'])
    end
  end
end
