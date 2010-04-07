class Main

  # just for test
  # show the nickname if user has logged in ML
  get "/user" do
    @cookie = request.cookies["orgnickp"]

    haml :"items/user", layout: false
  end

  get "/login" do

    haml :"auth/login", layout: false
  end

  post "/login" do
     session[:user] = params[:nombre]

     redirect session[:return_to]
  end

  get "/logout" do
    session[:user] = nil

    redirect "/items"
  end

  def require_login
    if current_user
      return true
    else
      session[:return_to] = request.fullpath
      session[:error] = "You need to log in before doing that."
      redirect "/login"
      return false
    end
  end

  def current_user
    !session[:user].nil?
  end

end
