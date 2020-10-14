require_relative "environment.rb"

url = "https://pitchfork.com/reviews/albums/"
html = open(url)
html_parsed_to_elements = Nokogiri::HTML(html)
review_elements = html_parsed_to_elements.css('.review')

review_elements.each do |review_element|
  artist = review_element.css("li")[0].text
  album_title = review_element.css("h2").text
  genre_name = review_element.css("a")[1].text

  review_url = review_element.css(".review__link")[0].attr("href")
  review_html = open("https://www.pitchfork.com/" + review_url)
  review_html_parsed_to_elements = Nokogiri::HTML(review_html)
  review = review_html_parsed_to_elements.css(".review-detail__abstract").text
  score = review_html_parsed_to_elements.css(".score").text

  genre = Genre.find_or_create_by(genre_name)
  Review.new(artist, album_title, genre, review, score)

  puts "================================="
  puts "Artist Name: #{artist}"
  puts "Album Title: #{album_title}"
  puts "Genre: #{genre}"
  puts ""
  puts "Score: #{score}"
  puts "Review: #{review}"
  puts ""
end

# Genre -< Reviews >- Artist
#







#
