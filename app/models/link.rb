class Link < ApplicationRecord
    validates :name, uniqueness: true
    validates :name, presence: true
    validates :url, presence: true
    def to_param
      "#{name.parameterize}"
    end
end
