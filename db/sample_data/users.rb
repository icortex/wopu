password = '123123'

puts "Creating users"
4.times do
  User.create(name: Faker::Name.name, email: Faker::Internet.email,
    password: password)
  print '.'
end
puts ''

puts "Creating nonprofits, needs and helps"
3.times do
  nonprofit = Nonprofit.find_by(name: Faker::Company.name)

  unless nonprofit
    nonprofit = Nonprofit.create(category: category, name: Faker::Company.name,
      available_tag_ids: available_tag_ids, mission: Faker::Lorem.paragraph(3), population: '25 people with...',
      start_date: Date.today - 2.years, certified: [true, false].sample, country: Faker::Lorem.words(1)[0], city:  Faker::Lorem.word)
    print 'f'
  end

  if nonprofit.needs.empty?
    3.times do |i|
      need = nonprofit.needs.create description: Faker::Lorem.sentence,
        title: Faker::Lorem.words.join(' '), purpose: Faker::Lorem.sentence,
        beneficiary: Faker::Lorem.sentence, deadline: rand(10).days.from_now
      print 'n'

      if i == 2
        need.create_result description: Faker::Lorem.sentence
        print 'r'
      end

      3.times do
        need.helps.create description: Faker::Lorem.sentence,
          helper: User.all.sample
        print '.'
      end
    end
  end
end
puts ''

