class User < ActiveRecord::Base
  attr_accessible :employee_id, :first_name, :email, :name, :tagline, :password, :password_confirmation
  has_secure_password

   valid_email_regex = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i                                                                                                              

   validates_presence_of :first_name
   validates :email, presence: true, :uniqueness => { :case_sensitive => false }, format: { with: valid_email_regex }

  validates :name,        uniqueness: { allow_blank: true }, presence: { if: Proc.new { |user| user.employee_id.blank? } }, length: { maximum: 32 }
  validates :employee_id, uniqueness: { allow_blank: true }, presence: { if: Proc.new { |user| user.name.blank?        } }, length: { maximum: 4 }, numericality: { allow_blank: true }
  validates_length_of :tagline, maximum: 128
  validates :password, length: { minimum: 6 }, presence: true

  before_save { |user| user.name = user.name.try(:downcase) }
  before_save :create_remember_token

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
