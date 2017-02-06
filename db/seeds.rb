# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'nokogiri'

module SeedData

  def self.extended(object)
    object.instance_exec do
      data = File.open('./CDD.kml') { |f| Nokogiri::XML(f) }

      entries = data.elements.first.elements.first.css("Placemark")

      entries.each do |entry|
        disaster_type = entry.css("name").text.split(":").first.strip
        disaster_description = entry.css("description").text
        coordinates = entry.css("Point").children.css("coordinates").text.split(",").map(&:to_f)
        Disaster.find_or_create_by(kind: disaster_type, description: disaster_description, longitude: coordinates[0], latitude: coordinates[1])
      end

      User.create(email: "batman@cave.com", password: "tookabullettotheparents") unless User.find_by(email: "batman@cave.com")
    end
  end
end


extend SeedData if ARGV.include?("db:seed")
