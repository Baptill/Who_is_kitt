# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"

# DELETE ALL RECORDS
Turn.destroy_all
Feature.destroy_all
Card.destroy_all
Character.destroy_all
CharacteristicQuestion.destroy_all
Characteristic.destroy_all
Player.destroy_all
User.destroy_all
Game.destroy_all

# Create the game
puts "seeding game"
new_game = Game.create(status: "pending")
puts "finished seeding game"

# Create the users
puts "seeding users"

user_briag = User.create!(email: "briag.martin@gmail.com", password: "password", password_confirmation: "password", nickname: "Briag", score: 1900, batch: "rennes")
file = URI.open("app/assets/images/profil-picture/briag.jpg")
user_briag.photo.attach(io: file, filename: "briag.jpg", content_type: "image/jpg")
user_briag.save

user_baptiste = User.create!(email: "baptil@gmail.com", password: "password", password_confirmation: "password", nickname: "Baptiste", score: 1600, batch: "rennes")
file = URI.open("app/assets/images/profil-picture/baptiste.jpg")
user_baptiste.photo.attach(io: file, filename: "baptiste.jpg", content_type: "image/jpg")
user_baptiste.save

user_charles = User.create!(email: "charleswoehl@gmail.com", password: "password", password_confirmation: "password", nickname: "Charles", score: 1400, batch: "rennes")
file = URI.open("app/assets/images/profil-picture/gaspard.png")
user_charles.photo.attach(io: file, filename: "gaspard.png", content_type: "image/png")
user_charles.save

user_jerome = User.create!(email: "jerome@gmail.com", password: "password", password_confirmation: "password", nickname: "Jerome", score: 1700, batch: "rennes")
file = URI.open("app/assets/images/profil-picture/jerome.png")
user_jerome.photo.attach(io: file, filename: "jerome.png", content_type: "image/png")
user_jerome.save

user_kevin = User.create!(email: "kevin@gmail.com", password: "password", password_confirmation: "password", nickname: "Kevin", score: 700, batch: "rennes")
file = URI.open("app/assets/images/profil-picture/kevin.jpg")
user_kevin.photo.attach(io: file, filename: "kevin.jpg", content_type: "image/jpg")
user_kevin.save

user_nicolas = User.create!(email: "nicolas@gmail.com", password: "password", password_confirmation: "password", nickname: "Nicolas", score: 900, batch: "rennes")
file = URI.open("app/assets/images/profil-picture/nicolas.jpg")
user_nicolas.photo.attach(io: file, filename: "nicolas.jpg", content_type: "image/jpg")
user_nicolas.save

user_gaetan = User.create!(email: "gaetan@gmail.com", password: "password", password_confirmation: "password", nickname: "Gaetan", score: 1300, batch: "rennes")
file = URI.open("app/assets/images/profil-picture/gaetan.jpg")
user_gaetan.photo.attach(io: file, filename: "gaetan.jpg", content_type: "image/jpg")
user_gaetan.save

user_bernard = User.create!(email: "bernard@gmail.com", password: "password", password_confirmation: "password", nickname: "Bernard", score: 900, batch: "rennes")
file = URI.open("app/assets/images/profil-picture/bernard.png")
user_bernard.photo.attach(io: file, filename: "bernard.png", content_type: "image/png")
user_bernard.save

user_louis = User.create!(email: "louis@gmail.com", password: "password", password_confirmation: "password", nickname: "Louis", score: 1200, batch: "rennes")
file = URI.open("app/assets/images/profil-picture/louis.jpg")
user_louis.photo.attach(io: file, filename: "louis.jpg", content_type: "image/jpg")
user_louis.save

user_mickael = User.create!(email: "mickael@gmail.com", password: "password", password_confirmation: "password", nickname: "Mickael", score: 700, batch: "rennes")
file = URI.open("app/assets/images/profil-picture/mickael.jpg")
user_mickael.photo.attach(io: file, filename: "mickael.jpg", content_type: "image/jpg")
user_mickael.save

user_camille = User.create!(email: "camille@gmail.com", password: "password", password_confirmation: "password", nickname: "Camille", score: 1400, batch: "rennes")
file = URI.open("app/assets/images/profil-picture/camille.jpg")
user_camille.photo.attach(io: file, filename: "camille.jpg", content_type: "image/jpg")
user_camille.save

user_etienne = User.create!(email: "etienne@gmail.com", password: "password", password_confirmation: "password", nickname: "Etienne", score: 1100, batch: "rennes")
file = URI.open("app/assets/images/profil-picture/etienne.jpg")
user_etienne.photo.attach(io: file, filename: "etienne.jpg", content_type: "image/jpg")
user_etienne.save



puts "seeded #{User.count} users"
puts "finished seeding users"

# Create the players
puts "seeding players"
player_one = Player.create(user: user_briag, game: new_game)
player_two = Player.create(user: user_baptiste, game: new_game)

# Create the characteristics
puts "seeding characteristics"
cheveux_courts = Characteristic.create(name: "cheveux courts")
cheveux_longs = Characteristic.create(name: "cheveux longs")
chauve = Characteristic.create(name: "chauve")
cheveux_boucles = Characteristic.create(name: "cheveux bouclés")
cheveux_blonds = Characteristic.create(name: "cheveux blonds")
cheveux_bruns = Characteristic.create(name: "cheveux bruns")
cheveux_roux = Characteristic.create(name: "cheveux roux")
cheveux_noirs = Characteristic.create(name: "cheveux noirs")
cheveux_blancs = Characteristic.create(name: "cheveux blancs")
lunettes = Characteristic.create(name: "lunettes")
barbe = Characteristic.create(name: "barbe")
moustache = Characteristic.create(name: "moustache")
chapeau = Characteristic.create(name: "chapeau")
boucles_doreilles = Characteristic.create(name: "boucles d'oreilles")
yeux_bleus = Characteristic.create(name: "yeux bleus")
yeux_marrons = Characteristic.create(name: "yeux marrons")
homme = Characteristic.create(name: "homme")
femme = Characteristic.create(name: "femme")
puts "seeded #{Characteristic.count} characteristics"
puts "finished seeding characteristics"

# Create the characters
puts "seeding characters"
alex = Character.new(name: "Alex")
file = URI.open("app/assets/images/guesswho_profiles/alex.jpg")
alex.photo.attach(io: file, filename: "alex.jpg", content_type: "image/jpg")
alex.save
puts "seeded alex is created"

alfred = Character.new(name: "Alfred")
file = URI.open("app/assets/images/guesswho_profiles/alfred.jpg")
alfred.photo.attach(io: file, filename: "alfred.jpg", content_type: "image/jpg")
alfred.save
puts "seeded alfred is created"

anita = Character.new(name: "Anita")
file = URI.open("app/assets/images/guesswho_profiles/anita.jpg")
anita.photo.attach(io: file, filename: "anita.jpg", content_type: "image/jpg")
anita.save
puts "seeded anita is created"

anne = Character.new(name: "Anne")
file = URI.open("app/assets/images/guesswho_profiles/anne.jpg")
anne.photo.attach(io: file, filename: "anne.jpg", content_type: "image/jpg")
anne.save
puts "seeded anne is created"

bernard = Character.new(name: "Bernard")
file = URI.open("app/assets/images/guesswho_profiles/bernard.jpg")
bernard.photo.attach(io: file, filename: "bernard.jpg", content_type: "image/jpg")
bernard.save
puts "seeded bernard is created"

bill = Character.new(name: "Bill")
file = URI.open("app/assets/images/guesswho_profiles/bill.jpg")
bill.photo.attach(io: file, filename: "bill.jpg", content_type: "image/jpg")
bill.save
puts "seeded bill is created"

charles = Character.new(name: "Charles")
file = URI.open("app/assets/images/guesswho_profiles/charles.jpg")
charles.photo.attach(io: file, filename: "charles.jpg", content_type: "image/jpg")
charles.save
puts "seeded charles is created"

claire = Character.new(name: "Claire")
file = URI.open("app/assets/images/guesswho_profiles/claire.jpg")
claire.photo.attach(io: file, filename: "claire.jpg", content_type: "image/jpg")
claire.save
puts "seeded claire is created"

david = Character.new(name: "David")
file = URI.open("app/assets/images/guesswho_profiles/david.jpg")
david.photo.attach(io: file, filename: "david.jpg", content_type: "image/jpg")
david.save
puts "seeded david is created"

eric = Character.new(name: "Eric")
file = URI.open("app/assets/images/guesswho_profiles/eric.jpg")
eric.photo.attach(io: file, filename: "eric.jpg", content_type: "image/jpg")
eric.save
puts "seeded eric is created"

frans = Character.new(name: "Frans")
file = URI.open("app/assets/images/guesswho_profiles/frans.jpg")
frans.photo.attach(io: file, filename: "frans.jpg", content_type: "image/jpg")
frans.save
puts "seeded frans is created"

george = Character.new(name: "George")
file = URI.open("app/assets/images/guesswho_profiles/george.jpg")
george.photo.attach(io: file, filename: "george.jpg", content_type: "image/jpg")
george.save
puts "seeded george is created"

herman = Character.new(name: "Herman")
file = URI.open("app/assets/images/guesswho_profiles/herman.jpg")
herman.photo.attach(io: file, filename: "herman.jpg", content_type: "image/jpg")
herman.save
puts "seeded herman is created"

joe = Character.new(name: "Joe")
file = URI.open("app/assets/images/guesswho_profiles/joe.jpg")
joe.photo.attach(io: file, filename: "joe.jpg", content_type: "image/jpg")
joe.save
puts "seeded joe is created"

maria = Character.new(name: "Maria")
file = URI.open("app/assets/images/guesswho_profiles/maria.jpg")
maria.photo.attach(io: file, filename: "maria.jpg", content_type: "image/jpg")
maria.save
puts "seeded maria is created"

max = Character.new(name: "Max")
file = URI.open("app/assets/images/guesswho_profiles/max.jpg")
max.photo.attach(io: file, filename: "max.jpg", content_type: "image/jpg")
max.save
puts "seeded max is created"

paul = Character.new(name: "Paul")
file = URI.open("app/assets/images/guesswho_profiles/paul.jpg")
paul.photo.attach(io: file, filename: "paul.jpg", content_type: "image/jpg")
paul.save
puts "seeded paul is created"

peter = Character.new(name: "Peter")
file = URI.open("app/assets/images/guesswho_profiles/peter.jpg")
peter.photo.attach(io: file, filename: "peter.jpg", content_type: "image/jpg")
peter.save
puts "seeded peter is created"

philip = Character.new(name: "Philip")
file = URI.open("app/assets/images/guesswho_profiles/philip.jpg")
philip.photo.attach(io: file, filename: "philip.jpg", content_type: "image/jpg")
philip.save
puts "seeded philip is created"

richard = Character.new(name: "Richard")
file = URI.open("app/assets/images/guesswho_profiles/richard.jpg")
richard.photo.attach(io: file, filename: "richard.jpg", content_type: "image/jpg")
richard.save
puts "seeded richard is created"

robert = Character.new(name: "Robert")
file = URI.open("app/assets/images/guesswho_profiles/robert.jpg")
robert.photo.attach(io: file, filename: "robert.jpg", content_type: "image/jpg")
robert.save
puts "seeded robert is created"

sam = Character.new(name: "Sam")
file = URI.open("app/assets/images/guesswho_profiles/sam.jpg")
sam.photo.attach(io: file, filename: "sam.jpg", content_type: "image/jpg")
sam.save
puts "seeded sam is created"

susan = Character.new(name: "Susan")
file = URI.open("app/assets/images/guesswho_profiles/susan.jpg")
susan.photo.attach(io: file, filename: "susan.jpg", content_type: "image/jpg")
susan.save
puts "seeded susan is created"

tom = Character.new(name: "Tom")
file = URI.open("app/assets/images/guesswho_profiles/tom.jpg")
tom.photo.attach(io: file, filename: "tom.jpg", content_type: "image/jpg")
tom.save
puts "seeded tom is created"
puts "seeded #{Character.count} characters"
puts "finished seeding characters"

# Create the features
puts "seeding features"

# Alex
puts "seeding features for Alex"
alex.features.create(characteristic: cheveux_courts)
alex.features.create(characteristic: cheveux_noirs)
alex.features.create(characteristic: yeux_marrons)
alex.features.create(characteristic: moustache)
alex.features.create(characteristic: homme)
puts "finished seeding features for Alex"

#Alfred
puts "seeding features for Alfred"
alfred.features.create(characteristic: cheveux_longs)
alfred.features.create(characteristic: cheveux_roux)
alfred.features.create(characteristic: yeux_bleus)
alfred.features.create(characteristic: moustache)
alfred.features.create(characteristic: homme)
puts "finished seeding features for Alfred"

#Anita
puts "seeding features for Anita"
anita.features.create(characteristic: cheveux_longs)
anita.features.create(characteristic: cheveux_blonds)
anita.features.create(characteristic: yeux_bleus)
anita.features.create(characteristic: femme)
puts "finished seeding features for Anita"

#Anne
puts "seeding features for Anne"
anne.features.create(characteristic: cheveux_courts)
anne.features.create(characteristic: cheveux_boucles)
anne.features.create(characteristic: cheveux_noirs)
anne.features.create(characteristic: yeux_marrons)
anne.features.create(characteristic: boucles_doreilles)
anne.features.create(characteristic: femme)
puts "finished seeding features for Anne"

#Bernard
puts "seeding features for Bernard"
bernard.features.create(characteristic: cheveux_courts)
bernard.features.create(characteristic: cheveux_bruns)
bernard.features.create(characteristic: yeux_marrons)
bernard.features.create(characteristic: chapeau)
bernard.features.create(characteristic: homme)
puts "finished seeding features for Bernard"

#Bill
puts "seeding features for Bill"
bill.features.create(characteristic: chauve)
bill.features.create(characteristic: cheveux_roux)
bill.features.create(characteristic: yeux_marrons)
bill.features.create(characteristic: barbe)
bill.features.create(characteristic: homme)
puts "finished seeding features for Bill"

#Charles
puts "seeding features for Charles"
charles.features.create(characteristic: cheveux_courts)
charles.features.create(characteristic: cheveux_blonds)
charles.features.create(characteristic: yeux_marrons)
charles.features.create(characteristic: moustache)
charles.features.create(characteristic: homme)
puts "finished seeding features for Charles"

#Claire
puts "seeding features for Claire"
claire.features.create(characteristic: cheveux_courts)
claire.features.create(characteristic: cheveux_roux)
claire.features.create(characteristic: yeux_marrons)
claire.features.create(characteristic: lunettes)
claire.features.create(characteristic: chapeau)
claire.features.create(characteristic: femme)
puts "finished seeding features for Claire"

#David
puts "seeding features for David"
david.features.create(characteristic: cheveux_courts)
david.features.create(characteristic: cheveux_blonds)
david.features.create(characteristic: yeux_marrons)
david.features.create(characteristic: barbe)
david.features.create(characteristic: homme)
puts "finished seeding features for David"

#Eric
puts "seeding features for Eric"
eric.features.create(characteristic: cheveux_courts)
eric.features.create(characteristic: cheveux_blonds)
eric.features.create(characteristic: yeux_marrons)
eric.features.create(characteristic: chapeau)
eric.features.create(characteristic: homme)
puts "finished seeding features for Eric"

#Frans
puts "seeding features for Frans"
frans.features.create(characteristic: cheveux_courts)
frans.features.create(characteristic: cheveux_boucles)
frans.features.create(characteristic: cheveux_roux)
frans.features.create(characteristic: yeux_marrons)
frans.features.create(characteristic: homme)
puts "finished seeding features for Frans"

#George
puts "seeding features for George"
george.features.create(characteristic: cheveux_courts)
george.features.create(characteristic: cheveux_blancs)
george.features.create(characteristic: yeux_marrons)
george.features.create(characteristic: chapeau)
george.features.create(characteristic: homme)
puts "finished seeding features for George"

#Herman
puts "seeding features for Herman"
herman.features.create(characteristic: chauve)
herman.features.create(characteristic: cheveux_roux)
herman.features.create(characteristic: yeux_marrons)
herman.features.create(characteristic: homme)
puts "finished seeding features for Herman"

#Joe
puts "seeding features for Joe"
joe.features.create(characteristic: cheveux_courts)
joe.features.create(characteristic: cheveux_boucles)
joe.features.create(characteristic: cheveux_blonds)
joe.features.create(characteristic: yeux_marrons)
joe.features.create(characteristic: lunettes)
joe.features.create(characteristic: homme)

#Maria
puts "seeding features for Maria"
maria.features.create(characteristic: cheveux_longs)
maria.features.create(characteristic: cheveux_bruns)
maria.features.create(characteristic: yeux_marrons)
maria.features.create(characteristic: boucles_doreilles)
maria.features.create(characteristic: chapeau)
maria.features.create(characteristic: femme)
puts "finished seeding features for Maria"

#Max
puts "seeding features for Max"
max.features.create(characteristic: cheveux_courts)
max.features.create(characteristic: cheveux_boucles)
max.features.create(characteristic: cheveux_noirs)
max.features.create(characteristic: yeux_marrons)
max.features.create(characteristic: moustache)
max.features.create(characteristic: homme)
puts "finished seeding features for Max"

#Paul
puts "seeding features for Paul"
paul.features.create(characteristic: cheveux_courts)
paul.features.create(characteristic: cheveux_blancs)
paul.features.create(characteristic: yeux_marrons)
paul.features.create(characteristic: lunettes)
paul.features.create(characteristic: homme)
puts "finished seeding features for Paul"

#Peter
puts "seeding features for Peter"
peter.features.create(characteristic: cheveux_courts)
peter.features.create(characteristic: cheveux_blancs)
peter.features.create(characteristic: yeux_bleus)
peter.features.create(characteristic: homme)
puts "finished seeding features for Peter"

#Philip
puts "seeding features for Philip"
philip.features.create(characteristic: cheveux_courts)
philip.features.create(characteristic: cheveux_boucles)
philip.features.create(characteristic: cheveux_noirs)
philip.features.create(characteristic: yeux_marrons)
philip.features.create(characteristic: barbe)
philip.features.create(characteristic: homme)
puts "finished seeding features for Philip"

#Richard
puts "seeding features for Richard"
richard.features.create(characteristic: chauve)
richard.features.create(characteristic: cheveux_bruns)
richard.features.create(characteristic: yeux_marrons)
richard.features.create(characteristic: barbe)
richard.features.create(characteristic: homme)
puts "finished seeding features for Richard"

#Robert
puts "seeding features for Robert"
robert.features.create(characteristic: cheveux_courts)
robert.features.create(characteristic: cheveux_bruns)
robert.features.create(characteristic: yeux_bleus)
robert.features.create(characteristic: homme)
puts "finished seeding features for Robert"

#Sam
puts "seeding features for Sam"
sam.features.create(characteristic: chauve)
sam.features.create(characteristic: cheveux_blancs)
sam.features.create(characteristic: yeux_marrons)
sam.features.create(characteristic: lunettes)
sam.features.create(characteristic: homme)
puts "finished seeding features for Sam"

#Susan
puts "seeding features for Susan"
susan.features.create(characteristic: cheveux_longs)
susan.features.create(characteristic: cheveux_blancs)
susan.features.create(characteristic: yeux_marrons)
susan.features.create(characteristic: femme)
puts "finished seeding features for Susan"

#Tom
puts "seeding features for Tom"
tom.features.create(characteristic: chauve)
tom.features.create(characteristic: cheveux_noirs)
tom.features.create(characteristic: yeux_bleus)
tom.features.create(characteristic: lunettes)
tom.features.create(characteristic: homme)
puts "finished seeding features for Tom"

puts "finished seeding features"

# Create the cards
puts "seeding cards for players"
[player_one, player_two].each do |player|
  Card.create(character: alex, player: player)
  Card.create(character: alfred, player: player)
  Card.create(character: anita, player: player)
  Card.create(character: anne, player: player)
  Card.create(character: bernard, player: player)
  Card.create(character: bill, player: player)
  Card.create(character: charles, player: player)
  Card.create(character: claire, player: player)
  Card.create(character: david, player: player)
  Card.create(character: eric, player: player)
  Card.create(character: frans, player: player)
  Card.create(character: george, player: player)
  Card.create(character: herman, player: player)
  Card.create(character: joe, player: player)
  Card.create(character: maria, player: player)
  Card.create(character: max, player: player)
  Card.create(character: paul, player: player)
  Card.create(character: peter, player: player)
  Card.create(character: philip, player: player)
  Card.create(character: richard, player: player)
  Card.create(character: robert, player: player)
  Card.create(character: sam, player: player)
  Card.create(character: susan, player: player)
  Card.create(character: tom, player: player)
end
puts "seeded #{Card.count} cards"
puts "finished seeding cards for players"
