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
end
