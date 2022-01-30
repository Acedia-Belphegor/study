require 'statesman' # gem install statesman

class State
  include Statesman::Machine

  state :init, initial: true
  state :active
  state :complete
  state :cancel

  transition from: :init, to: [:active]
  transition from: :active, to: [:complete, :cancel]

  before_transition(from: :init, to: :active) do |hogehoge, metadata|
    data = metadata.metadata[:data]
    hogehoge.actived(data)
  end

  before_transition(from: :active, to: :complete) do |hogehoge, metadata|
    data = metadata.metadata[:data]
    hogehoge.completed(data)
  end
end

class Hogehoge
  def perform
    state = State.new(self)
    puts state.current_state

    # init => active
    state.transition_to!(:active, { data: "hoge" })
    puts state.current_state
  
    # active => complete
    state.transition_to!(:complete, { data: "piyo" })
    puts state.current_state

    # 定義されていないステート遷移のためエラーになる: Cannot transition from 'complete' to 'cancel' (Statesman::TransitionFailedError)
    state.transition_to!(:cancel, { data: "hogehoge" })
  end

  def actived(data)
    puts data
  end

  def completed(data)
    puts data
  end
end

Hogehoge.new.perform
