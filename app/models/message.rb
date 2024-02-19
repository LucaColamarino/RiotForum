class Message < ApplicationRecord
    belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
    belongs_to :receive, class_name: 'User', foreign_key: 'receiver_id'
    attr_accessor :receive_email


end
