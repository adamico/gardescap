require "spec_helper"

feature "Un médecin qui souhaite participer au choix de gardes" do
  let!(:user)   { create(:user) }
  let!(:period) { create(:period, starts_at: "2014-05-02", ends_at: "2014-08-31") }
  let!(:garde)  { create(:garde, date: "2014-05-02", time: "Nuit longue") }

  background do
    login user
  end

  scenario "peut saisir son nom sur un créneau de garde" do
    visit "/gardes/prochain_choix"
    fill_in "garde_candidate_list", with: "martin"
    click_on "Enregistrer"
    find("#garde_candidate_list").value.should == "martin"
  end
end
