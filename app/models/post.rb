class Post < ApplicationRecord
    has_rich_text :content
    def is_published?
        return published < DateTime.now
    end
    
    def to_param
      "#{id}-#{title.parameterize}"
    end
end
