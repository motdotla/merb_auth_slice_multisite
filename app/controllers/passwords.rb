class MerbAuthSliceMultisite::Passwords <  MerbAuthSliceMultisite::Application
  
  def send_password
    @login_param = Merb::Authentication::Strategies::Multisite::Base.login_param
    @site_id_param = Merb::Authentication::Strategies::Multisite::Base.site_id_param
    @user = Merb::Authentication.user_class.first(@login_param => params[@login_param], @site_id_param => params[@site_id_param])
      
    if @user
      from = MerbAuthSliceMultisite[:send_password_from_email]
      raise "No :send_password_from_email option set for Merb::Slices::config[:merb_auth_slice_multisite][:send_password_from_email]" unless from 
      @user.password = @user.password_confirmation = new_generated_password     
      send_mail(MerbAuthSliceMultisite::SendPasswordMailer, :send_password, { :subject => (MerbAuthSliceMultisite[:send_password_subject] || "Forgetful? :)"), :from => from, :to => @user.email }, { :user => @user })
      @user.save
      redirect "/", :message => {:notice => "Password sent. Check your email."}
    else
      redirect "/", :message => {:error => "User with #{@login_param} \"%s\" not found".t(params[@login_param].freeze)}
    end
  end
  
  private
  
    def new_generated_password
      chars = ("a".."z").to_a
      start_password = ""
      1.upto(6) { |i| start_password << chars[rand(chars.size-1)] }
      @password = start_password
    end
 
end # MerbAuthSliceMultisite::Passwords