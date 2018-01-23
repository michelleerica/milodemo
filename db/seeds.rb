User.destroy_all
u1 = User.create email: 'milo@ga.co', name: 'Mi Lo', password: 'chicken'
u2 = User.create email: 'luke@ga.co', name: 'Lu Ke', password: 'chicken'
u3 = User.create email: 'joel@ga.co', name: 'Jo El', password: 'chicken'
puts "Created #{ User.all.length } users."
