require_relative 'test_helper'

class ReunionTest < Minitest::Test

  def setup
    @reunion = Reunion.new("1406 BE")
    @brunch = Activity.new("Brunch")
    @drinks = Activity.new("Drinks")
    @brunch.add_participant("Maria", 20)
    @brunch.add_participant("Luther", 40)
    @drinks.add_participant("Maria", 60)
    @drinks.add_participant("Luther", 60)
    @drinks.add_participant("Louis", 0)
  end


  def test_it_exists
    assert_instance_of Reunion, @reunion
  end

  def test_it_has_a_name
    assert_equal "1406 BE", @reunion.name
  end

  def test_it_has_no_activities_by_default
    assert_equal [], @reunion.activities
  end

  def test_it_can_add_activities
    @reunion.add_activity(@brunch)

    assert_equal [@brunch], @reunion.activities
  end

  def test_it_can_determine_total_cost_of_all_activities
    @reunion.add_activity(@brunch)
    @reunion.add_activity(@drinks)

    assert_equal 180, @reunion.total_cost
  end

  def test_it_can_determine_final_amounts_owed_by_all_participants
    @reunion.add_activity(@brunch)
    @reunion.add_activity(@drinks)

    expected = {"Maria" => -10, "Luther" => -30, "Louis" => 40}

    assert_equal expected, @reunion.breakout
  end

  def test_it_can_translate_breakout_to_string_for_summary
    @reunion.add_activity(@brunch)
    @reunion.add_activity(@drinks)

    expected = "Maria: -10\nLuther: -30\nLouis: 40"

    assert_equal expected, @reunion.summary
  end

  def test_it_can_determine_parties_owed_money_for_an_activity
    @reunion.add_activity(@brunch)

    assert_equal ["Luther"], @reunion.owed_parties("Maria", @brunch.owed)
  end

  def test_it_can_generate_a_detailed_breakout_of_amounts_owed
    reunion = Reunion.new("1406 BE")
    activity_1 = Activity.new("Brunch")
    activity_1.add_participant("Maria", 20)
    activity_1.add_participant("Luther", 40)
    activity_2 = Activity.new("Drinks")
    activity_2.add_participant("Maria", 60)
    activity_2.add_participant("Luther", 60)
    activity_2.add_participant("Louis", 0)
    activity_3 = Activity.new("Bowling")
    activity_3.add_participant("Maria", 0)
    activity_3.add_participant("Luther", 0)
    activity_3.add_participant("Louis", 30)
    activity_4 = Activity.new("Jet Skiing")
    activity_4.add_participant("Maria", 0)
    activity_4.add_participant("Luther", 0)
    activity_4.add_participant("Louis", 40)
    activity_4.add_participant("Nemo", 40)

    reunion.add_activity(activity_1)
    reunion.add_activity(activity_2)
    reunion.add_activity(activity_3)
    reunion.add_activity(activity_4)

    expected = {
      "Maria" => [
        {
          activity: "Brunch",
          payees: ["Luther"],
          amount: 10
        },
        {
          activity: "Drinks",
          payees: ["Louis"],
          amount: -20
        },
        {
          activity: "Bowling",
          payees: ["Louis"],
          amount: 10
        },
        {
          activity: "Jet Skiing",
          payees: ["Louis", "Nemo"],
          amount: 10
        }
      ],
      "Luther" => [
        {
          activity: "Brunch",
          payees: ["Maria"],
          amount: -10
        },
        {
          activity: "Drinks",
          payees: ["Louis"],
          amount: -20
        },
        {
          activity: "Bowling",
          payees: ["Louis"],
          amount: 10
        },
        {
          activity: "Jet Skiing",
          payees: ["Louis", "Nemo"],
          amount: 10
        }
      ],
      "Louis" => [
        {
          activity: "Drinks",
          payees: ["Maria", "Luther"],
          amount: 20
        },
        {
          activity: "Bowling",
          payees: ["Maria", "Luther"],
          amount: -10
        },
        {
          activity: "Jet Skiing",
          payees: ["Maria", "Luther"],
          amount: -10
        }
      ],
      "Nemo" => [
        {
          activity: "Jet Skiing",
          payees: ["Maria", "Luther"],
          amount: -10
        }
      ]
    }

    assert_equal expected, reunion.detailed_breakout
  end

end
