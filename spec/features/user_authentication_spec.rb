require "spec_helper"

feature "Un utilisateur qui souhaite acceder au site" do

  let(:user) { create(:user) }

  scenario "doit se connecter" do
    visit root_path
    page.should have_content /vous devez vous connecter/i
    login user
    page.should have_content /connecté/i
  end
end
