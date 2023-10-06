# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ApplicationRecord.transaction do
  # These `destroy_all` commands are not necessary--but will not hurt--if you
  # use `rails db:seed:replant`.
  puts "Destroying tables..."
  Toy.destroy_all
  Corgi.destroy_all
  Cat.destroy_all

  # Reset the id (i.e., primary key) counters for each table to start at 1
  puts "Resetting primary keys..."
  %w(cats corgis toys).each do |table_name|
    ApplicationRecord.connection.reset_pk_sequence!(table_name)
  end

  puts "Populating seed data..."
  cat1 = Cat.create!(name: "Sennacy")
  cat2 = Cat.create!(name: "Garfield")
  corgi1 = Corgi.create!(name: "Shelly")
  corgi2 = Corgi.create!(name: "Prisca")
  Toy.create!(name: "ball", toyable: cat1)
  Toy.create!(name: "ball", toyable: corgi1)
  Toy.create!(name: "stick", toyable: corgi2)
  Toy.create!(name: "mouse", toyable: cat1)
  Toy.create!(name: "yarn-ball", toyable: cat2)

  puts "Done!"
end