require "spec_helper"

feature "Un administrateur organisant le choix de garde" do
  given(:admin)   { create(:admin) }
  given!(:period) { create(:period, starts_at: "2014-11-01", ends_at: "2014-11-30") }

  background do
    login admin
    visit choix_path
    click_on "Initialiser/Reinitialiser les gardes sur la période"
  end

  scenario "rajoute manuellement une plage de journée fériée de semaine", :js do
    click_on "Nouvelle garde - jj - 03/11/2014"
    expect(page).to have_link "Détruire garde - jj - 03/11/2014"
    expect(Garde.last).to be_holiday
  end

  scenario "enlève une plage de journée de semaine"

  scenario "transforme en férié une plage de samedi après-midi"
  scenario "transforme en jour normal une plage de samedi après-midi"
  scenario "bloque le choix d'une plage de garde"
end
