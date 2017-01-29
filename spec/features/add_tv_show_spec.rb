require "spec_helper"

feature "user adds a new TV show" do
  # As a TV fanatic
  # I want to add one of my favorite shows
  # So that I can encourage others to binge watch it
  #
  # Acceptance Criteria:
  # * I must provide the title, network, and starting year.
  # * I can optionally provide the final year, genre, and synopsis.
  # * The synopsis can be no longer than 5000 characters.
  # * The starting year and ending year (if provided) must be
  #   greater than 1900.
  # * The genre must be one of the following: Action, Mystery,
  #   Drama, Comedy, Fantasy
  # * If any of the above validations fail, the form should be
  #   re-displayed with the failing validation message.

  scenario "successfully add a new show" do

    # have user visit the new page
    visit "/television_shows/new"
    # first have user fill out the forms
    fill_in 'title', with: 'Westworld'
    fill_in 'network', with: 'HBO'
    fill_in 'starting_year', with: '2016'
    select 'Drama', from: 'genre'

    # user enters data
    click_button 'Add TV Show'

    # should be taken to television_shows page with the show entered, listed
    expect(page).to have_content("Westworld (HBO)")

  end
  scenario "fail to add a show with invalid information" do
    visit "/television_shows/new"
    fill_in 'title', with: 'Westworld'
    fill_in 'network', with: 'HBO'
    fill_in 'starting_year', with: '1890'
    select 'Drama', from: 'genre'

    click_button 'Add TV Show'

    expect(page).to have_content("Starting year must be greater than 1900")
  end
end
