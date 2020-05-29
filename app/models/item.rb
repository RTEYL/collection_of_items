class Item < ActiveRecord::Base
  belongs_to :collection
  validates :img_url, allow_blank: true, format: {
    with: %r{\.gif|jpg|png|jpeg}i,
    message: 'must be a url for gif, jpg, or png image.'
  }
end