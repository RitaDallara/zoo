class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy, :assign_admin_role]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def assign_admin_role
    @user.add_role :admin
    redirect_to @user
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
# params[:user].delete(:password) if params[:user][:password].blank?
 #params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
  params[:user][:password] = @user.password if params[:user][:password].blank?
  params[:user][:password_confirmation] = @user.password if params[:user][:password_confirmation].blank?
  params[:user][:username] = @user.username if params[:user][:username].blank?

# if @user.update_attributes(params[:user]) 


    respond_to do |format|
     if @user.update(user_params)
      format.html { redirect_to @user, notice: 'User was successfully updated.' }
     format.json { head :no_content }
  else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
