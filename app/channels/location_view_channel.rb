class LocationViewChannel < ApplicationCable::Channel
  def subscribed
    reject unless current_user # 未ログインなら拒否
    @last_seen_at = Time.current
    stream_for current_user
  end

  def ping(data)
    now = Time.current
    diff = (now - @last_seen_at).round

    view = LocationView.find_or_create_by!(user_id: current_user.id)
    view.seconds_viewed = (view.seconds_viewed || 0) + diff
    view.update!(seconds_viewed: view.seconds_viewed)

    # クライアントに最新の秒数をブロードキャスト
    LocationViewChannel.broadcast_to(
      current_user,
      { seconds_viewed: view.seconds_viewed }
    )

    @last_seen_at = now
  end

  def unsubscribed
    now = Time.current
    diff = (now - @last_seen_at).to_i
    if diff.between?(1, 10)
      view = LocationView.find_or_create_by(user: current_user)
      view.increment!(:seconds_viewed, diff)
      LocationViewChannel.broadcast_to(
        current_user,
        { seconds_viewed: view.seconds_viewed }
      )
    end
  end
end
