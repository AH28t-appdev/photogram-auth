require "rails_helper"

feature "Devise" do
  scenario "root url set to photos index", points: 1 do
    user = FactoryGirl.create(:user)

    visit "/"
    if page.has_selector?("label", text: "Email")
      fill_in("Email", :with => user.email)
      fill_in("Password", :with => user.password)
      click_on("Log in")
    end

    expect(page).to have_link(nil, href: "/photos/new")
  end

  scenario "user authentication required for home page", points: 2 do
    visit "/"
    expect(page.current_path).to eq("/users/sign_in")
  end

  scenario "user authentication required for likes page", points: 1 do
    visit "/likes"
    expect(page.current_path).to eq("/users/sign_in")
  end

  scenario "login form works", points: 1 do
    user = FactoryGirl.create(:user)

    visit "/"
    fill_in("Email", :with => user.email)
    fill_in("Password", :with => user.password)
    click_on("Log in")

    expect(page).to have_content("Signed in successfully.")
  end

end
