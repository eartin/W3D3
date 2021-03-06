# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string           not null
#

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_many :submitted_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ShortendUrl
  
  has_many :visits,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Visit
  
  has_many :visited_urls,
    through: :visits,
    source: :visited_url
  
   
end
