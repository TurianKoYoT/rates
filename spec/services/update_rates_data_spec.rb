require 'rails_helper'

describe UpdateRatesData do
  it 'updates rates data from downloaded data' do
    usd_future_rate = 60.4012
    eur_future_rate = 75.1235

    rates_data = {
      'Valute': {
        'USD': {
          'Value': usd_future_rate,
        },
        'EUR': {
          'Value': eur_future_rate,
        },
      },
    }

    usd_rate = create(
      :rate,
      code: 'USD',
      value: '10.10',
    )

    eur_rate = create(
      :rate,
      code: 'EUR',
    )

    stub_request(:get, described_class::DATA_URL).to_return(status: 200, body: rates_data.to_json)

    described_class.update

    expect(usd_rate.reload.value).to eq usd_future_rate
    expect(eur_rate.reload.value).to eq eur_future_rate
  end

  it 'calls BroadcastRate' do
    broadcast_rate = double BroadcastRate
    allow(BroadcastRate).to receive(:new).and_return(broadcast_rate)
    allow(broadcast_rate).to receive(:broadcast)

    usd_future_rate = 60.4012

    rates_data = {
      'Valute': {
        'USD': {
          'Value': usd_future_rate,
        },
      },
    }

    _usd_rate = create(
      :rate,
      code: 'USD',
    )

    stub_request(:get, described_class::DATA_URL).to_return(status: 200, body: rates_data.to_json)

    described_class.update

    expect(broadcast_rate).to have_received(:broadcast).once
  end
end
