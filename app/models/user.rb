# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email_address   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#

class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :profile, class_name: "UserProfile", dependent: :destroy

  # Company Associations
  has_many :company_users, dependent: :destroy
  has_many :companies, through: :company_users
  has_many :owned_companies, class_name: "Company", foreign_key: "user_id", dependent: :destroy
  has_many :employer_companies, -> { where(company_users: { company_role_id: CompanyRole.employer.id }) },
           through: :company_users, source: :company
  has_many :employee_companies, -> { where(company_users: { company_role_id: CompanyRole.employee.id }) },
           through: :company_users, source: :company

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  accepts_nested_attributes_for :profile

  # Delegations
  delegate :name, :bio, :location, :website, :avatar, :avatar_url, :initials,
           to: :profile, allow_nil: true

  # Callbacks
  after_create :create_profile

  # Scopes
  scope :employers, -> { joins(:company_users).where(company_users: { company_role_id: CompanyRole.employer.id }) }
  scope :employees, -> { joins(:company_users).where(company_users: { company_role_id: CompanyRole.employee.id }) }
  scope :company_members, ->(company) { joins(:company_users).where(company_users: { company_id: company.id }) }

  # Instance Methods
  def company_role(company)
    company_users.find_by(company: company)&.company_role
  end

  def role
    return 'employer' if employer_companies.exists?
    return 'employee' if employee_companies.exists?
  end

  def is_owner?(company)
    owned_companies.include?(company)
  end

  def is_employer?(company)
    employer_companies.include?(company)
  end

  def is_employee?(company)
    employee_companies.include?(company)
  end

  def join_company(company, role_name)
    return if companies.include?(company)

    role = CompanyRole.find_by!(name: role_name)
    company_users.create!(company: company, company_role: role)
  end

  def leave_company(company)
    company_users.find_by(company: company)&.destroy
  end

  def companies_with_role(role_name)
    role = CompanyRole.find_by!(name: role_name)
    companies.joins(:company_users).where(company_users: { company_role_id: role.id })
  end

  private

  def create_profile
    build_profile(name: email_address.split("@").first).save
  end
end
