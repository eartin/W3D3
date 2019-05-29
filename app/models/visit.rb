# == Schema Information
#
# Table name: visits
#
#  id         :bigint           not null, primary key
#  url_id     :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Visit < ApplicationRecord
  validates :url_id, :user_id, presence: true
  validates_uniqueness_of :user_id, :scope => [:url_id]

  belongs_to :visitor,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
    
  belongs_to :visited_url,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :ShortenedUrl

  

end
