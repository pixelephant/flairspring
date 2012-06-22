class WpBlogPost < ActiveRecord::Base

	establish_connection "wordpress"

  set_table_name "wp_posts"
  set_primary_key "ID"

  def self.find_by_permalink(year, month, day, title)
    find(:first,
         :conditions => ["YEAR(post_date) = ? AND MONTH(post_date) = ? AND DAYOFMONTH(post_date) = ? AND post_name = ?", year.to_i, month.to_i, day.to_i, title])
  end
end