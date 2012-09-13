class String

  def tweetify
    self.convert_links.convert_usernames
  end

  def convert_links
    self.gsub(RConfig[:regexp].url) {|x| TLD.has_valid_tld?(x) ? "<a href=\"#{x}\" class=\"tweet-url\" target=\"_blank\">#{x}</a>" : x }
  end

  def convert_usernames
    self.gsub(/@(\w+)/) {|x| "<a href=\"http://www.twitter.com/#{x}\" class=\"tweet-user\" target=\"_blank\">#{x}</a>" }
  end
end
