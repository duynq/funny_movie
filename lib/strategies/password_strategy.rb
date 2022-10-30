class PasswordStrategy < ::Warden::Strategies::Base
  def valid?
    email || password
  end

  def authenticate!
    user = User.find_by_email email
    if user.nil? || user.password != password
      fail!('Email or Password are wrong')
    else
      success! user
    end
  end

  private

  def email
    params['user'].try :[], 'email'
  end

  def password
    params['user'].try :[], 'password_digest'
  end
end
