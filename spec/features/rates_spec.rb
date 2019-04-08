require 'rails_helper'

feature 'rates page' do
  scenario 'user sees rate on root page' do
    rate = create(
      :rate,
      value: '60.25',
    )

    visit root_path

    within('.container-fluid') do
      expect(page).to have_content rate.value
      expect(page).to have_content rate.code
      expect(page).to have_content I18n.t("currency.#{rate.code}")
    end
  end

  context 'data update from external service' do
    scenario 'user sees updated values' do
      usd_future_rate = 60.4012
      usd_previous_rate = 10.10

      rates_data = {
        'Valute': {
          'USD': {
            'Value': usd_future_rate,
          },
        },
      }

      usd_rate = create(
        :rate,
        code: 'USD',
        value: usd_previous_rate,
      )

      stub_request(:get, UpdateRatesData::DATA_URL).to_return(status: 200, body: rates_data.to_json)

      visit root_path

      within(".rate-card-#{usd_rate.id}") do
        expect(page).to have_content usd_previous_rate
        expect(page).to have_no_content usd_future_rate
      end

      UpdateRatesData.update

      within(".rate-card-#{usd_rate.id}") do
        expect(page).to have_content usd_future_rate
        expect(page).to have_no_content usd_previous_rate
      end
    end
  end
end
