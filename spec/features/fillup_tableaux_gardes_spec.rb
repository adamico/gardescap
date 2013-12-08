require "spec_helper"

feature "Un médecin qui souhaite participer au choix de gardes" do
  let!(:user)   { create(:user) }
  let!(:period) { create(:period, starts_at: "2014-05-02", ends_at: "2014-08-31") }
  let!(:garde)  { create(:garde, date: "2014-05-02", time: "Nuit Longue") }

  background do
    login user
  end

  scenario "peut saisir son nom sur un créneau de garde", js: true, focus: true do
    pending
    visit "/gardes/prochain_choix"
    click_on "Personne"
    select2tags "martin", css: ".select2-container"
    find("#garde_candidate_list").value.should == "martin"
  end
end
