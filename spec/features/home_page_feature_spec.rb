require 'rails_helper'
require 'play'

feature 'User visits home page' do
  scenario 'to see initial content' do
    visit root_path
    expect(page).to have_content('Play Analyzer')
    expect(page).to have_selector('[data-list="plays"]')
  end

  scenario 'to access play page' do
    visit root_path
    within('[data-list="plays"]') do
      click_on 'A Comedy of Errors'
    end
    expect(page).to have_content 'A Comedy of Errors'
  end
end
