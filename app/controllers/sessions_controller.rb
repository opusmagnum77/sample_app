class SessionsController < ApplicationController
	def new
	end

	def create
		render 'new'
		user = User.find_by(email: params[:session][:email].downcase)

		if user && user.authenticate(params[:session][:password])
			log_in user
			params[:session][:remember_me] == '1' ? remember(user) : forget(user)
			redirect_to user
			#log -user in redirect to the user's show page
		else
			flash.now[:danger] = 'Invalid email/pw combo' #create error message
			render 'new'
		end
	end

	def destroy
		log_out if logged_in?
		redirect_to root_url
	end

end


