require 'rails_helper'

feature 'User visits home page' do
  scenario 'to see initial content' do
    visit root_path
    expect(page).to have_content('Play Analyzer')
    expect(page).to have_selector('[data-list="plays"]')
  end
end
