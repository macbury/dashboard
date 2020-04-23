require_relative 'node_red'

red = NodeRed.new

SCHEDULER.every '10m', first_in: 0 do |job|
  data = red.poland

  data.each do |key, stats|
    start = stats.last
    last = stats[-30]

    event = "poland-#{key}"

    send_event(event, {
      current: start['last']&.round(2), last: last['last']&.round(2)
    })
  end
end