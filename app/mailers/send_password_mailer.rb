class MerbAuthSliceMultisite::SendPasswordMailer < Merb::MailController
 
  controller_for_slice MerbAuthSliceMultisite, :templates_for => :mailer, :path => "views"
 
  def send_password
    @user = params[:user]
    Merb.logger.info "Sending Password to #{@user.email}"
    render_mail :layout => nil
  end
 
end