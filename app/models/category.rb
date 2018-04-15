class Category < ApplicationRecord
  has_many :transactions

  def text_style
    "text-shadow: -1px 0 #{color}, 0 1px #{color}, 1px 0 #{color}, 0 -1px #{color};"
  end

  def border_style
    "border: 3px solid #{color}"
  end
end
