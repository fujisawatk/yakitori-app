module SetGon
  extend ActiveSupport::Concern

  def set_gon
    if user_signed_in?
      gon.current_user_id = current_user.id
      gon.current_user_name = current_user.nickname
    end
  end
end