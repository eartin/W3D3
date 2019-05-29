# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :user_id, :long_url, presence: true
  validates :short_url, presence: true, uniqueness: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
  
  has_many :visits,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Visit
  
  has_many :visitors,
    through: :visits,
    source: :visitor

  def self.random_code
    random = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(random)
      random = SecureRandom.urlsafe_base64
    end
    random
  end

  def self.create_short_url!(user, long_url)
    ShortenedUrl.new(user_id: user.id, long_url: long_url, short_url: ShortenedUrl.random_code).save
  end

  def num_clicks
    self.visitors.count
  end

  def num_uniques
    self.visitors.uniq.count
  end

  def num_recent_uniques
    Visit.where(["created_at > ? and url_id = ?", 60.minutes.ago, self.id]).uniq.count
  end

  


end
