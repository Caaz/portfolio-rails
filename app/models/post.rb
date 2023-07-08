class Post < ApplicationRecord
    has_rich_text :content
    has_one_attached :hero_image

    def is_published?
        return published? ? published < DateTime.now : false
    end
    
    def to_param
      "#{id}-#{title.parameterize}"
    end
end
