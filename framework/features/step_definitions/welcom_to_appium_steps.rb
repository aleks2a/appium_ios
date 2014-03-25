Given /^I reset iphone simulator launch application$/ do
  reset_simulator
  create_driver
end


When /^I press on "([^"]*)"$/ do |button|
  @app_driver.find_element(:name, button).click
end


Then /^I will print in terminal available searches$/ do
  @app_driver.find_element(:xpath, "tableview").find_elements(:xpath, "cell").each do |cell|
    puts cell.find_element(:xpath, "text").attribute :label
  end
end


Then /^I will delete "([^"]*)" from list$/ do |search_criteria|
  element_name = "Delete " + search_criteria
  @app_driver.find_element(:name, element_name).click
  sleep 0.5
  @app_driver.find_element(:name, "Delete").click
  sleep 0.5
  @app_driver.find_element(:name, "Done").click
end

Then /^searches list should( not)? include "([^"]*)"$/ do |negate, search_criteria|
  sleep 1
  if negate == " not"
    @app_driver.find_element(:xpath, "tableview").find_elements(:xpath, "cell").each do |cell|
      if (cell.find_element(:xpath, "text").attribute :label) == search_criteria
        raise "#{search_criteria} found in list"
      end
    end
  else
    array=[]
    @app_driver.find_element(:xpath, "tableview").find_elements(:xpath, "cell").each do |cell|
      array << (cell.find_element(:xpath, "text").attribute :label)
    end
    array.should include search_criteria
  end
end

Then /^I add "([^"]*)" as a New Search criteria$/ do |new_search|
  @app_driver.find_element(:xpath, "//window[3]/alert[1]/image[1]/textfield[1]").send_keys new_search
  @app_driver.find_element(:xpath, "//window[3]/alert[1]/tableview[2]/cell[1]").click
end


Then /^I should see module dialog with title "([^"]*)"$/ do |title|
  sleep 5
  @app_driver.find_element(:xpath, "//window[3]/alert[1]/scrollview[1]/text[1]").text.should == title
end


Then /^all items in list should be visible$/ do
  #element.displayed? will return true or false if element visible on screen or not (visible means - element exist on the screen but might be covered by another element)
  sleep 2
  array = @app_driver.find_element(:xpath, "//window[1]/tableview[1]").find_elements(:xpath, "//cell")
  array.each do |cell|
    cell.displayed?.should == true
  end
end

Given /^I turn (on|off) my WIFI$/ do |state|
  #WIFI network turn off/on
  #system "networksetup -setairportpower en0 off" if state == "off"
  #system "networksetup -setairportpower en0 on" if state == "on"
  #Wired network turn off/on
  # replace "student" with your user password
  system "echo student | sudo -S ipconfig set en0 NONE" if state == "off"
  system "echo student | sudo -S ipconfig set en0 DHCP" if state == "on"
end



Given /^I supress current location service$/ do
  #this step copying clients.plist file BEFORE starting test to simulator config folder, that allows to suppress current location module dialog in tests automatically
  close_simulator
  FileUtils.mkdir_p("/Users/#{ENV['USER']}/Library/Application Support/iPhone Simulator/7.0.3/Library/Caches/locationd/")
  #unless File.directory?("/Users/#{ENV['USER']}/Library/Application Support/iPhone Simulator/#{ENV['SDK']}/Library/Caches/locationd")
  location_service_dir = "/Users/#{ENV['USER']}/Library/Application Support/iPhone Simulator/7.0.3/Library/Caches/locationd/clients.plist"
  FileUtils.copy 'clients.plist', "#{location_service_dir}"
end
