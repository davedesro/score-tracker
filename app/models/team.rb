class Team < ActiveRecord::Base

  validates_presence_of :user1_id
  validates_presence_of :user2_id

  belongs_to :player1, foreign_key: :user1_id, class_name: 'User'
  belongs_to :player2, foreign_key: :user2_id, class_name: 'User'
end
