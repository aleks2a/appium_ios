require "selenium-webdriver"
require "rspec"
require "debugger"



def create_driver locale="en en_US"
  app_path = File.join(File.dirname(__FILE__), "..", "..", "Debug-iphonesimulator", "NearbyMe.app")
  server_url = "http://127.0.0.1:4723/wd/hub"
  capabilities =
      { 'device' => (ENV['DEVICE'] || 'iPhone Simulator'),
        'platform' => 'Mac',
        'version' => '7.0',
        'app' => app_path,
        'language' => locale.split(" ")[0],
        'locale' => locale.split(" ")[1]
      }
      @app_driver = Selenium::WebDriver.for(:remote, :desired_capabilities => capabilities, :url => server_url)
end

def close_simulator
  system "killall 'iPhone Simulator'"
end

def reset_simulator
  close_simulator
  system "rm -rf /Users/#{ENV['USER']}/Library/Application\\ Support/iPhone\\ Simulator/7.0.3/Applications"
end


After do |scenario|
  @app_driver.quit if @app_driver !=nil
  @app_driver = nil
end
