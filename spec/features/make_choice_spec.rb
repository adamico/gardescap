require "spec_helper"

feature "Un médecin souhaitant participer au tour de garde" do
  let(:user)    { create(:user, name: "martin") }
  let(:user2)    { create(:user, name: "dupond") }
  let(:user3)    { create(:user, name: "durand") }
  let(:user4)    { create(:user, name: "dumas") }

  background do
    login user
  end

  context "si le tableau est bouclé" do
    background do
      period = create(:period, starts_at: "2014-01-01", ends_at: "2014-01-31", state: "closed")
      garde = create(:garde, period: period, date: "2014-01-01", time: "jj")
      create(:assignment, user: user, garde: garde)
      visit choix_path
    end

    scenario "ne peut pas choisir des plages", :js do
      expect(page).not_to have_link "Choisir la garde - jj - 01/01/2014"
    end
  end

  context "si le tableau est actif" do
    let(:period) {create(:period, starts_at: "2014-01-01", ends_at: "2014-01-31")}
    let!(:garde)  {create(:garde, period: period, date: "2014-01-01", time: "jj")}
    let!(:garde2) {create(:garde, period: period, date: "2014-01-30", time: "jj")}
    let!(:garde4) {create(:garde, period: period, date: "2014-01-07", time: "jj")}

    background do
      create(:assignment, garde: garde2, user: user)
      [user2, user3, user4].each do |theuser|
        create(:assignment, garde: garde4, user: theuser)
      end
      visit choix_path
    end

    scenario "peut se rajouter sur une plage vide", :js do
      click_on "Choisir la garde - jj - 01/01/2014"
      expect(page).to have_link "Enlever martin de la Journée/AM Junior du 01/01/2014"
    end

    scenario "peut s'enlever d'une plage", :js do
      click_on "Enlever martin de la Journée/AM Junior du 30/01/2014"
      expect(page).not_to have_link "Enlever martin de la Journée/AM Junior du 30/01/2014"
    end

    scenario "ne peut pas se rajouter sur une plage pleine" do
      [user2, user3, user4].map(&:name).each do |theusername|
        expect(page).to have_content(theusername)
      end
      expect(page).not_to have_link "Choisir la garde - jj - 07/01/2014"
    end
  end
end
