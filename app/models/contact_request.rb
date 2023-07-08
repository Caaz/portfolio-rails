EMAIL_REGEX = /\A[^@]+@[^@]+\z/

class ContactRequest < ApplicationRecord
    validates :email, presence: true, format: { with: EMAIL_REGEX }
    has_rich_text :message
    
end
