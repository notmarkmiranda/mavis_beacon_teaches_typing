class Attempt < ActiveRecord::Base
  belongs_to :level
  validates :text, presence: true

  def self.take_top_three
    all.sort_by do |attempt|
      attempt.percent_correct
    end.reverse.take(3)
  end

  def percent_correct
    level.text.chars.zip(text.chars).count do |a, b|
      a == b
    end * 100 / level.text.size
  end

end
