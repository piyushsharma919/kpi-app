# == Schema Information
#
# Table name: user_profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  name       :string           not null
#  bio        :text
#  location   :string
#  website    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_profiles_on_user_id  (user_id)
#

class UserProfile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  validates :name, presence: true
  validates :bio, length: { maximum: 1000 }
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL" }, allow_blank: true

  def initials
    name.split.map(&:first).join.upcase
  end

  def avatar_url
    if avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_url(avatar)
    end
  end
end
