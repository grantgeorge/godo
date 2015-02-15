require 'spec_helper.rb'

feature "Looking up events", js: true do
  before do
    Event.create!(name: 'Skydiving with Friends')
    Event.create!(name: 'Exploring Space')
    Event.create!(name: 'Skydiving Meetup')
    Event.create!(name: 'Electro Concert')
  end
  scenario "finding events" do
    visit '/'
    fill_in "keywords", with: "skydiving"
    click_on "Search"

    expect(page).to have_content("Skydiving with Friends")
    expect(page).to have_content("Skydiving Meetup")
  end
end
