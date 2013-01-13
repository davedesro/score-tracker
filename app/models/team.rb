class Team < ActiveRecord::Base
  attr_accessor :user1_email, :user2_email
  attr_accessible :user1_email, :user2_email, :name


  validates_presence_of :user1_id, message: "doesn't seem to exist"
  validates_presence_of :user2_id, message: "doesn't seem to exist"

  belongs_to :player1, foreign_key: :user1_id, class_name: 'User'
  belongs_to :player2, foreign_key: :user2_id, class_name: 'User'

  before_validation :set_player_ids

  def name
    db_name = read_attribute(:name)
    db_name.present? ? db_name : "Boring Team Name #{self.id}"
  end

  private

  def set_player_ids
    self.player1 = User.find_by_email(user1_email) if user1_email.present?
    self.player2 = User.find_by_email(user2_email) if user1_email.present?
  end
end
