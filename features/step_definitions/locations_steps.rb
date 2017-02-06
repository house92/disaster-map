Given(/^sample data has been loaded$/) do
  require './db/seeds'
  extend SeedData
  @batman = User.find_by(email: "batman@cave.com")
  @batman = User.create(email: "batman@cave.com", password: "tookabullettotheparents") if @batman.nil?
end

When(/^I am logged on as "([^"]*)"$/) do |email|
  log_on_as(email)
end

When(/^I visit the "([^"]*)" page$/) do |path|
  visit(path)
end

Then(/^I should see markers appear$/) do
  binding.pry
  markers = page.evaluate_script("myMarkers")
  expect(markers.count).to eq(Disaster.count)
  eyjafjallajokull = markers.find{ |marker| marker["notes"] == "Eyjafjallajökull glacier, Iceland, April 14, 2010."}
  expect(eyjafjallajokull.lat).to be_within(0.01).of(63.63)
end
