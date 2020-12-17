class HomesController < ApplicationController
  def top
  end

  def show
    @user = current_user
  end

  def about
  end

end

