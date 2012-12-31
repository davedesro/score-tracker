class User < ActiveRecord::Base
  validates :name,        uniqueness: { allow_blank: true }, presence: { if: Proc.new { |user| user.employee_id.blank? } }, length: { maximum: 32 }
  validates :employee_id, uniqueness: { allow_blank: true }, presence: { if: Proc.new { |user| user.name.blank?        } }, length: { maximum: 4 }, numericality: { allow_blank: true }
  validates_length_of :tagline, maximum: 128

  attr_accessible :employee_id, :name, :tagline

  before_save { |user| user.name = user.name.try(:downcase) }
end
