class URLShortenerScript
  def self.sign_up(user_name, email)
    @current_user = User.find_by_email(email)
    @current_user = User.create(:user_name => user_name, :email => email) if @current_user.nil?
    @current_user
  end

  def self.login(email)
    @current_user = User.find_by(:email => email)
  end

  def self.shorten(long_url)
    short_url = SecureRandom.urlsafe_base64(6)
    @my_long_url = LongUrl.find_by_url(long_url)
    @my_long_url = LongUrl.create(:url => long_url) if @my_long_url.nil?

    @my_short_url = ShortUrl.create(:long_url_id => @my_long_url.id,
                                    :url => short_url, :user_id => @current_user.id)
    short_url
  end

  def self.expand(short_url)
    short_url_record = ShortUrl.find_by_url(short_url)
    long_url_record = LongUrl.find_by_id(short_url_record.long_url_id)
    display_comments(short_url_record.id)
    Launchy.open(long_url_record.url)
    Visit.create(:short_url_id => short_url_record.id, :user_id => @current_user.id)
  end

  def self.num_visits(short_url)
    short_url_record = ShortUrl.find_by_url(short_url)
    @visit_count = Visit.count(:id,:conditions => "short_url_id = #{short_url_record.id}",
                               :group => :short_url_id)
  end

  def self.num_distinct_visits(short_url)
    short_url_record = ShortUrl.find_by_url(short_url)
    @visit_count = Visit.count(:user_id, :distinct => true,
                        :conditions => "short_url_id = #{short_url_record.id}",
                        :group => :short_url_id)
  end

  def self.add_comment(short_url, comment)
    short_url_record = ShortUrl.find_by_url(short_url)
    Comment.create(:body => comment, :user_id => @current_user.id,
                   :short_url_id => short_url_record.id)
  end

  def self.display_comments(short_url_id)
    comments = Comment.where(:short_url_id => short_url_id)
    comments.each {|comment| puts comment.body}
  end

  def self.post_tag(tag, short_url)
    short_url_record = ShortUrl.find_by_url(short_url)
    TagTopic.create(:tag => tag, :short_url_id => short_url_record.id)
  end

  def self.top_url(tag)
    query =
      "SELECT short_urls.url FROM short_urls
      JOIN
        (SELECT COUNT(id) AS visit_count, short_url_id
        FROM visits
        GROUP BY short_url_id
        ORDER BY visit_count DESC) AS count
      ON short_urls.id = count.short_url_id
      JOIN tag_topics ON tag_topics.short_url_id = short_urls.id
      WHERE tag_topics.tag = ?
      LIMIT 1"

    ShortUrl.find_by_sql([query,tag])
  end

  def self.recent_visits(short_url)
    current_time = Time.now
    ten_mins_ago = current_time - 600
    puts ten_mins_ago
    short_url_record = ShortUrl.find_by_url(short_url)

    Visit.where("short_url_id = ? AND created_at >= ?", short_url_record.id, ten_mins_ago).length
  end
end








