# TAMU CSCE Honors Research Opportunities Platform

## Project Title and Description

**TAMU CSCE Honors Research Opportunities Platform**

This web application serves as a centralized platform for the Texas A&M University (TAMU) Computer Science and Engineering (CSCE) Honors program. It connects students seeking research opportunities with professors who have open positions.

* **Students:** Can browse available research projects posted by professors, view details, and submit applications.
* **Professors:** Can create, manage, and publish research position listings, and review applications submitted by students.

This project aims to streamline the process of finding and filling research positions within the CSCE Honors program, fostering collaboration and research engagement. It is developed using Ruby on Rails.

## Table of Contents

* [Project Title and Description](#project-title-and-description)
* [Table of Contents](#table-of-contents)
* [Requirements](#requirements)
* [External Dependencies](#external-dependencies)
* [Environmental Variables/Files](#environmental-variablesfiles)
* [Installation & Setup (Docker Recommended)](#installation--setup-docker-recommended)
* [Usage](#usage)
* [Features](#features)
* [Documentation](#documentation)
* [Credits & Acknowledgements](#credits--acknowledgements)
* [License](#license)
* [Third-Party Libraries](#third-party-libraries)
* [Contact Information](#contact-information)

## Requirements

This application has been developed and tested using the following components:

**Environment:**

* **OS:** Linux (Recommended), macOS, or Windows (with WSL2)
* **Docker:** Docker Engine v20+ and Docker Compose v1.29+ (Recommended for setup)
  * *Refer to the specific Docker setup guide provided for this project: [Link to Your Docker Guide/Instructions Here]*
* **Node.js:** v16+ (Potentially needed for asset pipeline via Webpacker)
* **Yarn:** v1.22+ (Potentially needed for asset pipeline via Webpacker)
* **Database:** PostgreSQL v12+ (Managed by Docker setup)

**Program (Based on Gemfile):**

* **Ruby:** `~> 3.3.0`
* **Rails:** `~> 8.0.1`
* **PostgreSQL Driver (pg gem):** `~> 1.1`
* **Authentication:** Devise, Omniauth, Omniauth-Google-Oauth2
* **Testing:** Rspec-Rails, Capybara, Selenium-Webdriver, SimpleCov
* **Other Key Gems:** Puma, Propshaft, Importmap-Rails, Turbo-Rails, Stimulus-Rails, Jbuilder, Dotenv-Rails, Factory_Bot_Rails, Faker

**Tools:**

* **Version Control:** Git
* **Code Repository:** GitHub - `<Your Repository URL>`
* **Code Analysis:** RuboCop (`rubocop-rails-omakase`), Brakeman
* **IDE:** VS Code, RubyMine, Atom, etc.
* **Containerization:** Docker Desktop / Docker Engine

## External Dependencies

Ensure you have the following software installed on your development machine before proceeding:

1. **Git:** Required for cloning the repository. [Download Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
2. **Docker & Docker Compose:** Required for the recommended containerized setup. [Download Docker Desktop](https://www.docker.com/products/docker-desktop) (includes Compose).
3. **(Optional) Node.js & Yarn:** May be needed if you work extensively with JavaScript assets managed by Webpacker. [Download Node.js](https://nodejs.org/) (includes npm, yarn can be installed via `npm install -g yarn`).
4. **(Optional) Ruby:** Only needed if *not* using the Docker setup. Version `3.3.0` is required. Use a version manager like `rbenv` or `rvm`.
5. **(Optional) PostgreSQL Client:** Useful for connecting directly to the database if needed.

## Environmental Variables/Files

This application uses environment variables for configuration, particularly for sensitive data like API keys.

1. **`.env` File:** Uses the `dotenv-rails` gem. Configuration variables are loaded from a `.env` file in the project root during development.
    * Create this file by copying the example: `cp .env.example .env` (You should create a `.env.example` file listing needed variables).
    * **Required Variables:**
        * `GOOGLE_CLIENT_ID`: Your Google Cloud project OAuth 2.0 Client ID.
        * `GOOGLE_CLIENT_SECRET`: Your Google Cloud project OAuth 2.0 Client Secret.
        * `DATABASE_USER`: Database username (used by Docker setup).
        * `DATABASE_PASSWORD`: Database password (used by Docker setup).
        * `DATABASE_HOST`: Database host (usually the Docker service name, e.g., `db`).
    * *Ensure `.env` is added to your `.gitignore` file to prevent committing secrets.*

2. **Rails Encrypted Credentials:** Standard Rails credentials (`config/credentials.yml.enc` and `config/master.key`) can also be used for storing secrets, especially in production. Edit them using:

    ```bash
    EDITOR=vim rails credentials:edit
    ```

    *(Replace `vim` with your preferred editor)*

## Installation & Setup (Docker Recommended)

Follow these steps to set up the application using Docker:

1. **Clone the Repository:**

    ```bash
    git clone <Repository URL>
    cd <repository-directory-name>
    ```

2. **Configure Environment:**
    * Copy the example environment file: `cp .env.example .env`
    * Edit the `.env` file and add your `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` obtained from Google Cloud Console. Fill in other variables as needed (defaults might be provided in your `docker-compose.yml`).
    * If using Rails encrypted credentials, ensure `config/master.key` exists or run `EDITOR=vim rails credentials:edit` to set them up.

3. **Refer to Docker Setup Guide:**
    * <https://docs.google.com/document/d/1ImylKuTKEmFmkJ_F_uViUY9ven0kXdrngKVwbKB5s1I/edit?tab=t.0>
4. **Access the Application:**
    Open your web browser and navigate to `http://localhost:3000` (or the port specified in your Docker configuration).

## Usage

1. **Access:** Navigate to the application URL (e.g., `http://localhost:3000`).
2. **Authentication:** Log in using your TAMU Google account via the Google OAuth button. The application should differentiate between Student and Professor roles based on user information or an initial setup step.
3. **Students:**
    * Browse the dashboard/listings page to see available research positions.
    * Click on a position to view details (description, requirements, professor contact).
    * Use the "Apply" button on a position page to submit your application (details required may vary).
4. **Professors:**
    * Navigate to your dashboard.
    * Use the "Create New Position" functionality to add a research opportunity, providing title, description, requirements, etc.
    * View your created positions and manage them (edit, publish/unpublish, delete).
    * Access the applications submitted for your positions to review candidate details.

*(Consider adding screenshots or a short GIF here demonstrating the key workflows)*

## Features

* **User Authentication:** Secure login via Google OAuth 2.0 (leveraging `@tamu.edu` accounts).
* **Role-Based Access Control:** Distinct interfaces and permissions for Students and Professors.
* **Professor Features:**
  * CRUD operations (Create, Read, Update, Delete) for research position listings.
  * Application viewing and management dashboard.
* **Student Features:**
  * Browse, search, and filter research positions.
  * View detailed information about positions.
  * Submit applications online.
* **Responsive Design:** (Assuming standard Rails/Hotwire setup) Usable across different devices.

## Documentation

* **Code Documentation:** Inline comments are used throughout the codebase where necessary.
* **External Resources:**
  * [Ruby on Rails Guides](https://guides.rubyonrails.org/)
  * [Devise Wiki](https://github.com/heartcombo/devise/wiki)
  * [OmniAuth Google OAuth2 Strategy](https://github.com/zquestz/omniauth-google-oauth2)
  * [Hotwire (Turbo/Stimulus)](https://hotwired.dev/)
  * ChatGPT
* **Project Specific Documentation:**
  * [Training Guide](https://docs.google.com/document/d/1Ymh9H1q_4eZsfIR-wA9qHKEiRFAbnDZ9kdz5Umr2Jyc/edit?tab=t.0)

## Credits & Acknowledgements

* **Development Team:**
  * `David Vanderklay`
  * `Vyas Chitti`
  * `Tam Pham`
  * `Min Sithu Maung`
* **Project Advisor(s):**
  * `Pauline Wade`
* **Institution:** Texas A&M University, Department of Computer Science and Engineering, Honors Program.
* **Acknowledgements:** We thank the CSCE department and the Honors program for the opportunity to develop this project.

## License

This project is licensed under the `MIT` License - see the `LICENSE` file for details.

## Third-Party Libraries

This project relies on several open-source Ruby gems, including but not limited to:

* **Core Framework:** `rails`, `puma`, `propshaft`, `pg` (PostgreSQL Adapter)
* **Frontend:** `importmap-rails`, `turbo-rails`, `stimulus-rails`, `jbuilder`, `webpacker`
* **Authentication:** `devise`, `omniauth`, `omniauth-google-oauth2`, `omniauth-rails_csrf_protection`
* **Development & Testing:** `debug`, `web-console`, `rspec-rails`, `factory_bot_rails`, `faker`, `capybara`, `selenium-webdriver`, `webdrivers`, `simplecov`
* **Utilities:** `dotenv-rails`, `bootsnap`, `tzinfo-data`, `rexml`, `yaml_db`
* **Code Quality:** `rubocop`, `brakeman`, `rubocop-rails-omakase`
* **Background Jobs/Caching/WebSockets:** `solid_cache`, `solid_queue`, `solid_cable`
* **Deployment:** `kamal`

Please refer to the `Gemfile` for a complete list and specific versions. Licenses for each gem can typically be found in their respective source repositories.

## Contact Information

For any questions, issues, or feedback regarding this project, please contact:

* `Vyas Chitti` - `chittiv1113@tamu.edu`
