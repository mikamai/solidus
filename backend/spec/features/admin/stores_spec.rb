require 'spec_helper'

describe 'Stores', type: :feature do
  stub_authorization!

  it 'admin should be able to edit default_currency' do
    visit spree.new_admin_store_path

    fill_in 'store_name', with: 'Solidus Store'
    fill_in 'store_code', with: 'solidus'
    fill_in 'store_url', with: 'example.solidus.io'
    fill_in 'store_mail_from_address', with: 'from@solidus.io'
    select 'EUR', from: 'store_default_currency'
    click_button "Create"

    @store = Spree::Store.last

    expect(@store.default_currency).to eq 'EUR'
  end
end
