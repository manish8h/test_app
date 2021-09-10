class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  # GET /users or /users.json
  def index
    # @users = User.all
    @users = User.page(params[:page])
  end

  # GET /users/1 or /users/1.json
  def show
    @users_articles = @user.articles.page(params[:page])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    # if @user.save
    #   flash[:success] = "Welcome to the Test App #{@user.username}!"
    #   redirect_to articles_path
    # else
    #   render :new
    # end
    # ===============
    # only render or redirect_to per action
    # ===============
    respond_to do |format|
      if @user.save
        flash[:success] = "Welcome to the Test App #{@user.username}!"
        # format.html { redirect_to @user, notice: "User was successfully created." }
        format.html { redirect_to articles_path }
        format.json { render :'articles/index', status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = "Your Account is updated"
        # format.html { redirect_to @user, notice: "User was successfully updated." }
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user
      flash[:danger] = "You can edit or delete your profile"
      redirect_to root_path
    end
  end
end
