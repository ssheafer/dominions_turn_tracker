class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if Dom3::ConstData::ADMINS.include?(@user.email)
			@user.admin = true
		else
			@user.admin = false
		end
		if verify_recaptcha(:message => "Recaptcha not filled correctly") && @user.save
			redirect_to root_url, :notice => "Signed up!"
		else
			render :new
		end
	end
	
	def activate
	  if (@user = User.load_from_activation_token(params[:id]))
	    @user.activate!
	    redirect_to(login_path, :notice => 'User was successfully activated.')
	  else
	    not_authenticated
	  end
	end

	
end
