require 'test_helper'

class AttemptTest < ActiveSupport::TestCase
  def test_it_is_valid_with_text
    assert Attempt.new(text: "Here is a typing test.").valid?
  end

  def test_it_is_not_valid_with_empty_text
    refute Attempt.new(text: "").valid?
  end

  def test_it_scores_text_of_attempt
    level_text   = "Here is a typing test."
    attempt_text = "Here is a typing text."

    level   = Level.new(title: "Level 1", text: level_text)
    attempt = level.attempts.new(text: attempt_text)

    assert_equal 95, attempt.percent_correct
  end

  def test_it_can_get_the_top_three_attempts
    level_1 = Level.create(title: "Easy", text: "Type this!")
    level_2 = Level.create(title: "Medium", text: "Type this!")
    a1 = Attempt.create(text:"Type this?", level_id: level_1.id)
    a2 = Attempt.create(text:"Type thsi!", level_id: level_2.id)
    a4 = Attempt.create(text:"Type txsi?", level_id: level_1.id)
    a3 = Attempt.create(text:"Type txsi!", level_id: level_1.id)

    assert_equal [a1, a2, a3], Attempt.take_top_three
  end
end
