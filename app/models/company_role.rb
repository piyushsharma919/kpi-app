# == Schema Information
#
# Table name: company_roles
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :string           not null
#  active      :boolean         default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_company_roles_on_name  (name) UNIQUE
#

class CompanyRole < ApplicationRecord
  # Associations
  has_many :company_users, dependent: :restrict_with_error
  has_many :users, through: :company_users
  has_many :companies, through: :company_users

  # Validations
  validates :name, presence: true, uniqueness: true, format: { with: /\A[a-z_]+\z/ }
  validates :description, presence: true, length: { maximum: 255 }

  # Callbacks
  before_validation :normalize_name, if: -> { name.present? }

  # Scopes
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :by_name, -> { order(:name) }

  # Class Methods
  def self.employer
    find_by!(name: "employer")
  end

  def self.employee
    find_by!(name: "employee")
  end

  def self.find_by_name!(name)
    find_by!(name: name)
  end

  # Instance Methods
  def to_param
    name
  end

  def deactivate!
    update!(active: false)
  end

  def activate!
    update!(active: true)
  end

  def employer?
    name == "employer"
  end

  def employee?
    name == "employee"
  end

  private

  def normalize_name
    self.name = name.downcase
  end
end
