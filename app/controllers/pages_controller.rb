class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @community = Community.first  # Or any logic to fetch the community you want
  end
end
