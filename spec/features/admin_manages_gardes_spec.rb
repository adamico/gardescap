require "spec_helper"

feature "Un administrateur organisant le choix de garde" do
  given(:admin)   { create(:admin) }
  given!(:period) { create(:period, starts_at: "2014-11-01", ends_at: "2014-11-30") }
  given!(:garde)  { period.gardes.create(time: "jj", date: "2014-11-01", holiday: false)}

  background do
    login admin
    visit choix_path
  end

  scenario "rajoute manuellement une plage de journée fériée de semaine", :js do
    click_on "Nouvelle garde - jj - 03/11/2014"
    expect(page).to have_link "Détruire garde - jj - 03/11/2014"
    expect(Garde.last).to be_holiday
  end

  scenario "enlève une plage de journée de semaine", :js do
    click_on "Nouvelle garde - jj - 03/11/2014"
    click_on "Détruire garde - jj - 03/11/2014"
    expect(page).to have_link "Nouvelle garde - jj - 03/11/2014"
  end

  scenario "transforme en jour normal une plage fériée" do
    pending
    click_on "Nouvelle garde - jj - 03/11/2014"
    click_on "toggle-holiday-jj-2014-11-03"
    expect(Garde.last).not_to be_holiday
  end

  scenario "transforme en férié une plage normale" do
    pending
    click_on "toggle-holiday-jj-2014-11-01"
    expect(garde).to be_holiday
  end

  scenario "bloque le choix d'une plage de garde"
end
