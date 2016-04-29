require 'test_helper'

class ListTopScoringAttemptsTest < ActionDispatch::IntegrationTest
  test "shows top 3 scoring attempts" do
    level_1 = Level.create(title: "Easy", text: "Type this!")
    level_2 = Level.create(title: "Medium", text: "Type this!")
    a1 = Attempt.create(text:"Type this?", level_id: level_1.id)
    a2 = Attempt.create(text:"Type thsi!", level_id: level_2.id)
    a4 = Attempt.create(text:"Type txsi?", level_id: level_1.id)
    a3 = Attempt.create(text:"Type txsi!", level_id: level_1.id)

    visit '/attempts'

    within('ol li:nth-child(1)') do
      assert page.has_content? a1.text
      assert page.has_content? level_1.title
    end

    within('ol li:nth-child(2)') do
      assert page.has_content? a2.text
      assert page.has_content? level_2.title
    end

    within('ol li:nth-child(3)') do
      assert page.has_content? a3.text
      assert page.has_content? level_1.title
    end

    refute page.has_content? a4.text

  end
end
