require_relative 'test_helper'

class ActivityTest < Minitest::Test

  def setup
    @brunch = Activity.new("Brunch")
  end

  def test_it_exists
    assert_instance_of Activity, @brunch
  end

  def test_it_has_a_name
    assert_equal "Brunch", @brunch.name
  end

  def test_it_has_no_participants_by_default
    assert_equal ({}), @brunch.participants
  end

  def test_it_can_add_participants
    @brunch.add_participant("Maria", 20)

    expected = {"Maria" => 20}

    assert_equal expected, @brunch.participants
  end

  def test_it_has_a_total_cost
    @brunch.add_participant("Maria", 20)

    assert_equal 20, @brunch.total_cost
  end

  def test_it_can_determine_cost_per_participant
    @brunch.add_participant("Maria", 20)
    @brunch.add_participant("Luther", 40)

    assert_equal 30, @brunch.split
  end

  def test_it_can_determine_amount_owed_by_participants
    @brunch.add_participant("Maria", 20)
    @brunch.add_participant("Luther", 40)

    expected = {"Maria" => 10, "Luther" => -10}

    assert_equal expected, @brunch.owed
  end

end
