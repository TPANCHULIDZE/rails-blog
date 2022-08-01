require 'faker'

class BlogFiller

  def create_users
    password =  Faker::Internet.password(min_length: 6)
    20.times do
      User.create({
        username: Faker::Name.name,
        email: Faker::Internet.unique.email,
        password: password,
        password_confirmation: password,
        avatar: Faker::Avatar.image(slug: "my-own-slug", size: "50x50", format: "jpg")
      })
    end
  end

  def create_posts
    user_start = User.last.id - 20
    50.times do
      Post.create({
        title:Faker::Alphanumeric.alpha(number: 15),
        body: Faker::Alphanumeric.alpha(number: 30),
        user_id: Faker::Number.within(range: user_start..(user_start + 20)),
        member_only: Faker::Boolean.boolean,
        approve: Faker::Boolean.boolean
      })
    end
  end

  def create_comments
    user_start = User.last.id - 20
    post_start = Post.last.id - 50

    100.times do
      user = User.find_by(id: Faker::Number.within(range: user_start..(user_start + 20)))
      Comment.create({
        body: Faker::Alphanumeric.alpha(number: 20),
        post_id: Faker::Number.within(range: post_start..(post_start + 50)),
        user_id: user.id,
        author: user.username
      }) if user
    end
  end

  def create_likes
    user_start = User.last.id - 20
    post_start = Post.last.id - 50
    1000.times do
      user_id = Faker::Number.within(range: user_start..(user_start + 20))
      post_id = Faker::Number.within(range: post_start..(post_start + 50))
      Like.create({
        post_id: post_id,
        user_id: user_id
      }) if Like.where(user_id: user_id, post_id: post_id).empty?
    end
  end

  def create_locations
    user_start = User.last.id - 20
    30.times do
      address = Faker::Address.full_address_as_hash(:longitude,
                                    :latitude,
                                    :country,
                                    country_name_to_code: {name: 'united_states'})
      address[:user_id] = Faker::Number.within(range: user_start..(user_start + 20))
      location = Location.create(address)
    end
  end

  def create_mobiles
    user_start = User.last.id - 20
    Faker::Config.locale = 'en-US'
    30.times do
      country = Faker::Address.country_code
      number = Faker::PhoneNumber.phone_number
      mobile = Mobile.create({
        number: number,
        country: country,
        user_id: Faker::Number.within(range: user_start..(user_start + 20))
      })
    end
  end
end


blog_filler = BlogFiller.new()

blog_filler.create_users
blog_filler.create_posts
blog_filler.create_likes
blog_filler.create_comments
blog_filler.create_mobiles
blog_filler.create_locations

