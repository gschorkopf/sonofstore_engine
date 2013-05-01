module EmojiHelper
 def emojify(content)
    h(content).to_str.gsub(/:([a-z0-9\+\-_]+):/) do |match|
      if Emoji.names.include?($1)
        image_url = get_image_location("#{$1}.png")
       result = '<img alt="' + $1 + '" height="20" src="' +
        image_url +
        '" style="vertical-align:middle" width="20" />'
      else
        match
      end
    end.html_safe if content.present?
  end

 def get_image_location file_name
  s3 = AWS::S3.new
  blah = s3.buckets[ENV['AWS_BUCKET']].objects["emoji/#{file_name}"]
 blah.url_for(:read).to_s

 end
end
