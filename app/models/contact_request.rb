EMAIL_REGEX = /\A[^@]+@[^@]+\z/

class ContactRequest < ApplicationRecord
    validates :email, presence: true, format: { with: EMAIL_REGEX, message: "must contain @" }
    validates :name, presence: true
    validates :message, presence: true
    # has_rich_text :message
    
end
