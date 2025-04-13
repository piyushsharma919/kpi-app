# == Schema Information
#
# Table name: company_users
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  company_id      :integer          not null
#  company_role_id :integer          not null
#
# Indexes
#
#  index_company_users_on_company_id                      (company_id)
#  index_company_users_on_company_id_and_company_role_id  (company_id,company_role_id)
#  index_company_users_on_company_role_id                 (company_role_id)
#  index_company_users_on_user_id                         (user_id)
#  index_company_users_on_user_id_and_company_id          (user_id,company_id) UNIQUE
#

class CompanyUser < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :company
  belongs_to :company_role

  # Validations
  validates :user_id, uniqueness: { scope: :company_id, message: "is already associated with this company" }
  validate :validate_role_availability, on: :create

  # Callbacks
  after_create :notify_user
  after_destroy :cleanup_orphaned_company

  # Scopes
  scope :active, -> { joins(:company).where(companies: { active: true }) }
  scope :inactive, -> { joins(:company).where(companies: { active: false }) }
  scope :by_joined_date, -> { order(created_at: :desc) }
  scope :employers, -> { joins(:company_role).where(company_roles: { name: "employer" }) }
  scope :employees, -> { joins(:company_role).where(company_roles: { name: "employee" }) }

  # Class Methods
  def self.find_by_user_and_company(user, company)
    find_by(user: user, company: company)
  end

  # Instance Methods
  def employer?
    company_role.employer?
  end

  def employee?
    company_role.employee?
  end

  def active?
    company.active?
  end

  def deactivate!
    company.update!(active: false)
  end

  def activate!
    company.update!(active: true)
  end

  private

  def validate_role_availability
    return unless company_role
    return if company_role.active?

    errors.add(:company_role, "is not available")
  end

  def notify_user
    # Implement notification logic here
    # Example: UserMailer.company_association_notification(self).deliver_later
  end

  def cleanup_orphaned_company
    return unless company.users.empty?
    company.destroy
  end
end
