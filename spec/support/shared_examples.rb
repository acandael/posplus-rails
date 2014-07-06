shared_examples "require sign in" do
  it "redirects to the sign in page" do
    session[:user_id] = nil 
    action
    expect(response).to redirect_to signin_path 
  end
end

shared_examples "require admin" do
  it "redirects to the home page" do
    session[:user_id] = Fabricate(:user)
    action
    expect(response).to redirect_to home_path
  end
end
