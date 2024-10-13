class LeaderboardsController < ApplicationController
  def show
    # Calculate the sum of each user's counters and order by the total amount in descending order
    @leaders = User.joins(:counters)
      .select('users.*, SUM(counters.amount) AS total_counted')
      .group('users.id')
      .order('total_counted DESC')
  end
end
