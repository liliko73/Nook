require 'capybara/rspec'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :remote_chrome
  end
end

Capybara.register_driver :remote_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: ENV.fetch('SELENIUM_DRIVER_URL', 'http://chrome:4444/wd/hub'),
    options: options
  )
end

Capybara.server_host = '0.0.0.0'
Capybara.server_port = 3001
Capybara.app_host = 'http://web:3001'
