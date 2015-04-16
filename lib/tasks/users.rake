namespace :users do
  desc "TODO"
  task load: :environment do
    puts 'begin'
    f = File.open("/tmp/output.txt", 'r+')
    f.each_line do |line|
      ll = line.split("\t")
      User.create(yid: ll[0])
      Business.create(yid: ll[1])
      Review.create(business_id: ll[1], user_id: ll[0], description:ll[7], date: ll[6])
      print '.'
    end
    f.close
    puts 'done'
  end

  task business: :environment do
    puts 'begin'
    f = File.open("/tmp/business.json", 'r+')
    f.each_line do |line|
      l = JSON.parse(line)
      if !Business.find_by_yid(l['business_id'])
        b = Business.new
        b.name = l['name']
        b.neighborhoods = l['neighborhoods'].join(',')
        b.full_address = l['full_address']
        b.city = l['city']
        b.state = l['state']
        b.review_count = l['review_count']
        b.categories = l['categories'].join(',')
        b.open = l['open']
        b.hours = l['hours'].to_s
        b.yattributes = l['attributes'].to_s
        b.stars = l['stars']
        b.longitude = l['longitude']
        b.latitude = l['latitude']
        b.save(validate: false)
        print '.'
      else
        print '-'
      end
    end
    f.close
    puts 'done'
  end

  task tips: :environment do
    puts 'begin'
    f = File.open("/tmp/yelp/tip.json", 'r+')
    f.each_line do |line|
      l = JSON.parse(line)
      b = Business.find_by_yid(l['business_id'])
      u = User.find_by_yid(l['user_id'])
      if b && u
        Tip.create(description: l['text'], business_id: l['business_id'], user_id: l['user_id'], date: l['date'], likes: l['likes'])
        print '.'
      else
        print '-'
      end
    end
    f.close
    puts 'done'
  end



  task update: :environment do
    puts 'begin'
    f = File.open("/tmp/yelp/user.json", 'r+')
    f.each_line do |line|
      l = JSON.parse(line)
      u = User.find_by_yid(l['user_id'])
      if u
        u.name = l['name']
        u.review_count = l['review_count']
        u.average_stars = l['average_stars']
        u.votes = l['votes'].to_s
        u.friends = l['friends'].join(',')
        u.compliments = l['compliments'].to_s
        u.fans = l['fans']
        u.save 
        print '.'
      else
        print '-'
      end
    end
    f.close
    puts 'done'
  end

  task review: :environment do
    puts 'begin'
    f = File.open("/tmp/review.json", 'r+')
    f.each_line do |line|
      l = JSON.parse(line)
      b = Business.find_by_yid(l['business_id'])
      u = User.find_by_yid(l['user_id'])
      if b && u
        r = Review.new
        r.yid = l['review_id']
        r.business_id = l['business_id']
        r.user_id = l['user_id']
        r.stars =l['stars']
        r.votes = l['votes'].to_s
        r.description =l['text']
        r.date =l['date']
        r.save 
        print '.'
      else
        print '-'
      end
    end
    f.close
    puts 'done'
  end


  task review_yid: :environment do
    puts 'begin'

    Review.all.each do |r|
      u = User.where(yid: r.user_yid).first
      b = Business.where(yid: r.business_yid).first
      r.user_id = u.id
      r.business_id = b.id
      r.save
      print '.'
    end
    puts 'done'
  end
end
