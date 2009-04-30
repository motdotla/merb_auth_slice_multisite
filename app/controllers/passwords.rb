class MerbAuthSliceMultisite::Passwords <  MerbAuthSliceMultisite::Application
 
  def forgot_password
    render
  end
  
  def send_password
    @login_param = Merb::Authentication::Strategies::Multisite::Base.login_param
    @site_id_param = Merb::Authentication::Strategies::Multisite::Base.site_id_param
    @user = Merb::Authentication.user_class.find_with_login_param(@login_param, params[@login_param])
    @user = Merb::Authentication.user_class.first(@login_param => params[@login_param], @site_id_param => params[@site_id_param])
      
    if @user
      from = MerbAuthSliceMultisite[:send_password_from_email]
      raise "No :send_password_from_email option set for Merb::Slices::config[:merb_auth_slice_multisite][:send_password_from_email]" unless from      
      send_mail(MerbAuthSliceMultisite::SendPasswordMailer, :send_password, { :subject => (MerbAuthSliceMultisite[:send_password_subject] || "Your password"), :from => from, :to => @user.email }, { :user => @user })
      # MerbAuthSliceMultisite::SendPasswordMailer.dispatch_and_deliver(:send_password, :subject => (MerbAuthSliceMultisite[:send_password_subject] || "Your password"), :from => from, :to => @user.email), :user => @user)
      redirect "/", :message => {:notice => "Password sent".t}
    else
      message[:error] = "User with #{@login_param} \"%s\" not found".t(params[@login_param].freeze)
      render :forgot_password
    end
  end
 
end # MerbAuthSliceMultisite::Passwords