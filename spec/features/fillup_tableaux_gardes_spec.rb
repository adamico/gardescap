require "spec_helper"

feature "Un médecin qui souhaite participer au choix de gardes" do
  let!(:user)   { create(:user) }
  let!(:period) { create(:period, starts_at: "2014-05-02", ends_at: "2014-08-31") }
  let!(:garde)  { create(:garde, date: "2014-05-02", time: "jj", period: period) }

  background do
    login user
  end

  scenario "peut choisir des gardes" do
    visit "/choix"
    expect(page).to have_link "Choisir garde - jj - 02/05/2014"
  end

  scenario "ne peut pas choisir des gardes si le choix est clos" do
    period.close!
    visit "/choix"
    expect(page).not_to have_link "Choisir garde - jj - 02/05/2014"
  end
end
