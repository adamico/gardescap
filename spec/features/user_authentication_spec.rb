require 'spec_helper'

feature 'Un utilisateur qui souhaite acceder au site' do

  let(:user) { create(:user) }

  scenario 'doit se connecter' do
    visit root_path
    expect(page).to have_content(/vous devez vous connecter/i)
    login user
    expect(page).to have_content(/connecté/i)
  end
end
