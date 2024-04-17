class HomeController < ApplicationController
  def index
    @unapproved_users = User.where(approved: "false")
  end
end
