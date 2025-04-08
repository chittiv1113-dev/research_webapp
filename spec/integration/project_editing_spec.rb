# spec/system/project_editing_spec.rb
require 'rails_helper'

RSpec.describe "Project Editing", type: :system do
  let!(:faculty_user) { User.create!(email: 'faculty@example.com', name: 'Test Faculty User', uid: 'faculty123', provider: 'google_oauth2') }
  let!(:faculty) { Faculty.create!(user: faculty_user, department: 'CS') }
  let!(:project) do
    Project.create!(
      title: "Original Project Title",
      description: "Original Description",
      num_positions: 1, # Use integer here for consistency
      areas_of_research: 'Original Area',
      # -- Use new date fields for creation --
      start_date: Date.today - 1.month,
      end_date: Date.today + 3.months,
      # -- Optionally set selection_type if needed for default view state --
      # selection_type: 'date-range',
      faculties: [ faculty ] # Associate using the let! variable
    )
  end

  # --- Admin User Setup (using let! for cleaner setup) ---
  let!(:admin_user) { User.create!(email: 'admin@example.com', name: 'Test Admin User', uid: 'admin789', provider: 'google_oauth2') }
  let!(:admin_record) { Admin.create!(user: admin_user) } # Create the Admin association


  before do
    # Keep rack_test for now as requested
    driven_by(:rack_test)

    # Mock OmniAuth for faculty login by default
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: faculty_user.uid, # Use uid from let! block
      info: {
        email: faculty_user.email,
        name: faculty_user.name
      },
      credentials: { token: 'mock_token', expires_at: Time.now + 1.week }
    })
  end

  def login_as(user)
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        provider: 'google_oauth2',
        uid: user.uid,
        info: { email: user.email, name: user.name },
        credentials: { token: "mock_token_#{user.id}", expires_at: Time.now + 1.week }
      })
      visit new_user_session_path
      # Ensure the button text matches your view
      click_button "Google"
      # Expect redirect to projects index after login
      expect(page).to have_current_path(projects_path)
  end

  def logout
    # Assuming you have a sign out link with this text or ID
    # Adjust if your sign out method is different (e.g., button_to with method: :delete)
    if page.has_link?("Sign Out")
      click_link "Sign Out"
    elsif page.has_button?("Sign Out")
       click_button "Sign Out"
    else
       # If using DELETE method link without Turbo, might need direct path visit or driver method
       # Example for non-JS DELETE link:
       # find('a[data-method="delete"][href="/users/sign_out"]').click
       puts "WARN: Could not find standard Sign Out link/button." # Add warning
       visit destroy_user_session_path # Less ideal, but might work for rack_test
    end
    # Expect redirection to login page after logout
    expect(page).to have_current_path(new_user_session_path)
  end


  # --- Sunny Day Scenarios ---

  context "when logged in as faculty owner" do
    before { login_as(faculty_user) }

    scenario "can edit their project successfully (excluding dates)" do
      visit projects_path
      # Find the specific project card and click its edit link
      within("#project_#{project.id}") do # Assuming you add an ID like id="project_<%= project.id %>" to the card div in index.html.erb
         click_link "Edit"
      end
      # Alternative if no ID: find('.card', text: project.title).click_link('Edit')

      expect(page).to have_current_path(edit_project_path(project))
      expect(find_field("project_title").value).to eq("Original Project Title")

      fill_in "project_title", with: "Updated Project Title"
      fill_in "project_description", with: "Updated Description"
      fill_in "project_num_positions", with: "2" # Now a number field
      fill_in "project_areas_of_research", with: "Updated Area"
      # --- DO NOT fill_in start_date or end_date ---
      # --- DO NOT fill_in start_semester ---

      click_button "Update Project"

      # Expect redirect to show page
      expect(page).to have_current_path(project_path(project))
      expect(page).to have_selector(".alert-info", text: "Project was successfully updated.") # Check flash message

      # Verify updated content on show page
      expect(page).to have_selector("h3.card-title", text: "Updated Project Title") # Use selector from show page
      expect(page).to have_selector(".project-description", text: "Updated Description")
      expect(page).to have_selector(".project-description", text: /Number of Positions:.*2/i)
      expect(page).to have_selector(".project-description", text: /Research Area:.*Updated Area/i)

      # Verify dates haven't changed (check formatting against show page output)
      expect(page).to have_selector(".project-description", text: /Start Date:.*#{project.start_date.strftime('%Y-%m-%d')}/i)
      expect(page).to have_selector(".project-description", text: /End Date:.*#{project.end_date.strftime('%Y-%m-%d')}/i)

      # Verify original title is gone
      expect(page).not_to have_selector("h3.card-title", text: "Original Project Title")
    end

    scenario "can delete their project" do
        visit project_path(project)
        # Use accept_confirm for browser confirmation dialogs if using a JS driver later
        # For rack_test, confirmations are automatically accepted
        click_button "Delete Project"

        expect(page).to have_current_path(projects_path)
        expect(page).to have_selector(".alert-info", text: "Project was successfully deleted.")
        expect(Project.find_by(id: project.id)).to be_nil
    end

    scenario "sees validation errors when editing with invalid input" do
        visit edit_project_path(project)

        fill_in "Project Title", with: ""  # Make the title blank
        fill_in "Number of Positions", with: "abc" # Try invalid number input
        click_button "Update Project"

        # Should remain on edit page due to errors
        expect(page).to have_current_path(project_path(project)) # Stays on edit path upon failure usually (check controller update action)
        expect(current_path).to eq(project_path(project)) # More explicit check

        # Check for standard Rails error wrapper
        expect(page).to have_selector("#error_explanation", text: /prohibited this project from being saved/i)
        # Check for specific validation errors
        expect(page).to have_selector("#error_explanation li", text: "Title can't be blank")
        expect(page).to have_selector("#error_explanation li", text: /Num positions is not a number|Num positions must be an integer/i) # Check specific number validation error
    end
  end

  # --- Rainy Day & Admin Scenarios ---

  scenario "Faculty user cannot edit another faculty's project" do
    # Create a second faculty user
    other_faculty_user = User.create!(email: 'faculty2@example.com', name: 'Other Faculty', uid: 'faculty456', provider: 'google_oauth2')
    Faculty.create!(user: other_faculty_user, department: 'EE')

    # Log in as the second faculty user
    login_as(other_faculty_user)

    # Try to visit the edit page for the first user's project directly
    visit edit_project_path(project)

    # Expect redirection (adjust path based on your authorization logic)
    expect(page).to have_current_path(root_path) # Redirect usually goes to index or root
    # expect(page).to have_selector(".alert-alert", text: /You are not authorized/i) # Check alert message
  end


  context "when logged in as admin" do
      before { login_as(admin_user) }

      scenario "can edit any project" do
        visit edit_project_path(project)
        expect(page).to have_current_path(edit_project_path(project)) # Should be allowed

        fill_in "Project Title", with: "Updated by Admin"
        fill_in "Number of Positions", with: 5
        click_button "Update Project"

        expect(page).to have_current_path(project_path(project))
        expect(page).to have_selector(".alert-info", text: "Project was successfully updated.")
        expect(page).to have_selector("h3.card-title", text: "Updated by Admin") # Check title on show page
         expect(page).to have_selector(".project-description", text: /Number of Positions:.*5/i)
      end

      scenario "can delete any project" do
        visit project_path(project)
        click_button "Delete Project"

        expect(page).to have_current_path(projects_path)
        expect(page).to have_selector(".alert-info", text: "Project was successfully deleted.")
        expect(Project.find_by(id: project.id)).to be_nil
      end
  end

  context "when not logged in" do
      scenario "cannot access edit page" do
        # No need to logout if starting fresh, but good practice if inheriting state
        # logout # Ensure no user is logged in if tests share state (unlikely with let!)
        visit edit_project_path(project)
        expect(page).to have_current_path(new_user_session_path) # Expect redirect to login
        expect(page).to have_selector(".alert-alert", text: /You need to sign in/i) # Check Devise flash message
      end

      scenario "cannot access update action" do
        # logout # Ensure logged out
        # For rack_test, directly submitting to the path simulates the request
        page.driver.submit :patch, project_path(project), { project: { title: "Attempted Update" } }

        # Check the response status or redirection after the direct request
        # Devise should intercept and redirect to login
        expect(page.driver.status_code).to be_in([ 302, 303 ]) # Redirect status
        # Hard to check current_path after direct driver submission with rack_test,
        # focus on status code or check logs/controller behavior if needed.
        # Alternatively, visit the page after submission attempt and check redirection:
        visit project_path(project) # Visit any authenticated page
        expect(page).to have_current_path(new_user_session_path) # Should be forced to login
      end
   end
end
