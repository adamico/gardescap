require "spec_helper"

feature "Un médecin du tour de garde souhaitant participer au tour de garde" do

  let(:user)    { create(:user, name: "martin") }
  let(:user2)    { create(:user, name: "dupond") }
  let(:user3)    { create(:user, name: "durand") }
  let(:user4)    { create(:user, name: "dumas") }
  let!(:period) { create(:period, starts_at: "2014-01-01", ends_at: "2014-01-31") }
  let!(:garde)  { create(:garde, period: period, date: "2014-01-01", time: "jj")}
  let!(:garde2)  { create(:garde, period: period, date: "2014-01-15", time: "jj")}
  let!(:garde3)  { create(:garde, period: period, date: "2014-01-30", time: "jj")}
  let!(:garde4)  { create(:garde, period: period, date: "2014-01-07", time: "jj")}

  background do
    login user
    create(:assignment, garde: garde2, user: user2)
    create(:assignment, garde: garde3, user: user)
    create(:assignment, garde: garde4, user: user2)
    create(:assignment, garde: garde4, user: user3)
    create(:assignment, garde: garde4, user: user4)
    visit choix_path
  end

  scenario "peut se rajouter sur une garde vide", js: true do
    click_on "Choisir la garde - jj - 01/01/2014"
    expect(page).to have_text "martin"
  end

  scenario "peut s'enlever d'une plage", js: true do
    click_on "martin"
    expect(page).not_to have_text "martin"
  end

  scenario "peut se rajouter sur une plage non pleine", js: true do
    click_on "Choisir la garde - jj - 15/01/2014"
    expect(page).to have_text "dupond, martin"
  end

  scenario "ne peut pas se rajouter sur une plage pleine" do
    expect(page).not_to have_link "Choisir la garde - jj - 07/01/2014"
  end

  scenario "peut clicker sur son nom" do
    expect(page).to have_link "martin"
  end

  scenario "ne doit pas pouvoir clicker sur le nom d'un autre candidat" do
    expect(page).not_to have_link "dupond"
  end
end
