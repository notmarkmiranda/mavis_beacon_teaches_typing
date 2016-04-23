class Attempt < ActiveRecord::Base
  belongs_to :level
  validates :text, presence: true

  def percent_correct
    level.text.chars.zip(text.chars).select do |a, b|
      a == b
    end.size * 100 / level.text.size
  end
  
end
