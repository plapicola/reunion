class Activity

  attr_reader :name,
              :participants

  def initialize(name)
    @name = name
    @participants = {}
  end

  def add_participant(name, cost)
    @participants[name] = cost
  end

  def total_cost
    @participants.sum do |name, cost|
      cost
    end
  end

  def split
    total_cost / @participants.count
  end

  def owed
    @participants.inject({}) do |owed, participant|
      owed[participant.first] = split - participant.last
      owed
    end
  end

end
