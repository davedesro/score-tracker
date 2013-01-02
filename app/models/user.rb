class User < ActiveRecord::Base
  attr_accessible :employee_id, :name, :tagline, :password, :password_confirmation
  has_secure_password

  validates :name,        uniqueness: { allow_blank: true }, presence: { if: Proc.new { |user| user.employee_id.blank? } }, length: { maximum: 32 }
  validates :employee_id, uniqueness: { allow_blank: true }, presence: { if: Proc.new { |user| user.name.blank?        } }, length: { maximum: 4 }, numericality: { allow_blank: true }
  validates_length_of :tagline, maximum: 128
  validates :password, length: { minimum: 6 }, presence: true

  before_save { |user| user.name = user.name.try(:downcase) }
end
