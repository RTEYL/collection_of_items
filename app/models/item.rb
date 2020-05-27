class Item < ActiveRecord::Base
  belongs_to :collection
  validates :img_url, format: {with: /\.(png|jpg)\Z/i}
end
