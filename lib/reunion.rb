class Reunion
  attr_reader :name,
              :activities

  def initialize(name)
    @name = name
    @activities = []
  end

  def add_activity(activity)
    @activities << activity
  end

  def total_cost
    @activities.sum do |activity|
      activity.total_cost
    end
  end

  def breakout
    @activities.inject(Hash.new(0)) do |result, activity|
      activity.owed.each do |name, amount|
        result[name] += amount
      end
      result
    end
  end

  def summary
    breakout.inject("") do |result, participant|
      result += "#{participant.first}: #{participant.last}\n"
    end.chomp
  end

  def detailed_breakout
    final = {}
    @activities.each do |activity|
      payment_summary(activity, final)
    end
    final
  end

  def payment_summary(activity, summary)
    attendees = activity.owed
    attendees.each do |name, amount|
      if !summary[name]
        summary[name] = []
      end
      persons_owed = owed_parties(name, attendees)
      summary[name] << {activity: activity.name,
                        payees: persons_owed,
                        amount: (amount / persons_owed.count)}
    end
  end

  def owed_parties(name, participants)
    owed = participants.find_all do |participant, amount|
      (participants[name] > 0 && amount < 0) ||
      (participants[name] < 0 && amount > 0)
    end
    owed.map {|name, amount| name}
  end
end
