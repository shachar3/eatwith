require 'net/http'
require 'uri'

desc 'Import NY Restaurants & Reviews'
namespace :import_restaurants_reviews do
  @zomatoRestBaseURL = 'https://developers.zomato.com/api/v2.1/'
  @zomatoApiKey = '64051c9e2b0354b2938b32fcf4cd8fb2'
  @maxRestaurantToQuery = 20

  task :clear_db => :environment do
    Review.delete_all
    Restaurant.delete_all
    Cuisine.delete_all
  end
  
  task :restaurants => :environment do
    json_restaurants = get_restaurants_from_zomato
    restaurants = JSON.parse(json_restaurants)
    restaurants['establishments'].take(@maxRestaurantToQuery).each do |rest|
      id = rest['establishment']['id']
      # if !Restaurant.exists?(zomato_id: id)
      json_restaurant_detail = get_restaurant_details_from_zomato(id.to_s)
      next if json_restaurant_detail.nil?
      restaurant_detail = JSON.parse(json_restaurant_detail)

      json_restaurant_reviews = get_restaurant_reviews_from_zomato(id.to_s)
      restaurant_reviews = JSON.parse(json_restaurant_reviews)

      insert_restaurants_reviews_to_db(restaurant_detail, restaurant_reviews)
      # end
    end
  end
  def insert_restaurants_reviews_to_db(rd, rr)
    rest = Restaurant.create(:name => rd['name'], :zomato_id => rd['id'], :address => rd['location']['address'], :latitude => rd['location']['latitude'], :longitude => rd['location']['longitude'])
    if !rest.nil?
      puts rd['cuisines']
      rd['cuisines'].split(',').each do |c|
        c = c.strip if c.present?
        next if c.blank?
        cuisine = Cuisine.where(name: c).first
        if cuisine.nil?
          cuisine = Cuisine.create(:name => c, :icon => '')
        end
        cuisine.restaurants << rest
      end
      if rr['reviews_count'].to_i > 0
        rr['user_reviews'].each do |rev|
          user = ''
          if rev['review'].key?(:user)
            user = rev['review']['user']['name']
          end
          review = Review.create(:name => user, :rating => rev['review']['rating'].to_i, :comment => rev['review']['review_text'])
          rest.reviews << review
        end
      end
    end
  end

  def get_restaurants_from_zomato
    make_http_request('establishments?city_id=280')
  end

  def get_restaurant_details_from_zomato(res_id)
    make_http_request('restaurant?res_id=' + res_id)
  end

  def get_restaurant_reviews_from_zomato(res_id)
    make_http_request('reviews?res_id=' + res_id)
  end

  def make_http_request(url_resource_and_params)
    uri = URI.parse(@zomatoRestBaseURL + url_resource_and_params)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(uri.request_uri)
    req['X-Zomato-API-Key'] = @zomatoApiKey
    req['Content-Type'] = 'application/json'
    res = http.request(req)
    res.body if res.is_a?(Net::HTTPSuccess)
  end
end
