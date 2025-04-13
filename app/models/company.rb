# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  slug       :string           not null
#  website    :string
#  logo_url   :string
#  user_id    :integer          not null
#  active     :boolean          default(TRUE)
#  settings   :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_companies_on_slug     (slug) UNIQUE
#  index_companies_on_user_id  (user_id)
#

class Company < ApplicationRecord
  # Associations
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :company_users, dependent: :destroy
  has_many :users, through: :company_users
  has_many :employees, -> { where(company_users: { company_role_id: CompanyRole.employee.id }) },
           through: :company_users, source: :user
  has_many :employers, -> { where(company_users: { company_role_id: CompanyRole.employer.id }) },
           through: :company_users, source: :user

  # Validations
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9-]+\z/ }
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL" }, allow_blank: true
  validates :logo_url, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL" }, allow_blank: true

  # Callbacks
  before_validation :generate_slug, if: -> { slug.blank? && name.present? }
  before_validation :normalize_website, if: -> { website.present? }
  before_validation :normalize_logo_url, if: -> { logo_url.present? }

  # Scopes
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :by_name, -> { order(:name) }
  scope :search, ->(query) { where("name ILIKE ?", "%#{query}%") }

  # Class Methods
  def self.find_by_slug!(slug)
    find_by!(slug: slug)
  end

  # Instance Methods
  def to_param
    slug
  end

  def add_user(user, role_name)
    role = CompanyRole.find_by!(name: role_name)
    company_users.create!(user: user, company_role: role)
  end

  def remove_user(user)
    company_users.find_by(user: user)&.destroy
  end

  def user_role(user)
    company_users.find_by(user: user)&.company_role
  end

  def has_user?(user)
    users.include?(user)
  end

  def is_owner?(user)
    owner == user
  end

  def is_employer?(user)
    employers.include?(user)
  end

  def is_employee?(user)
    employees.include?(user)
  end

  private

  def generate_slug
    self.slug = name.parameterize
  end

  def normalize_website
    self.website = URI.parse(website).to_s
  rescue URI::InvalidURIError
    errors.add(:website, "is invalid")
  end

  def normalize_logo_url
    self.logo_url = URI.parse(logo_url).to_s
  rescue URI::InvalidURIError
    errors.add(:logo_url, "is invalid")
  end
end
