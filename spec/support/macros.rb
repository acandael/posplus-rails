def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end
def set_current_admin(admin=nil)
  session[:user_id] = admin || Fabricate(:admin).id
end
