class Backend::UsersController < Backend::BaseController
  authorize_resource

  before_action :find_user, only: [:edit, :update, :destroy]

  def index
    @breadcrumbs = {"User" => admin_users_path, "List" => nil}
    @users = User.includes(:profile).order(:email).page(params[:page]).per(CONSTANT::PAGE_SIZE)
  end

  def new
    @user = User.new
    @user.build_profile
    @hobbies = Hobby.select(:id, :name)
    @breadcrumbs = {"User" => admin_users_path, "New" => nil}
  end

  def create
    @user = User.new user_params

    ActiveRecord::Base.transaction do
      if @user.save
        update_user_target @user, "hobbies"

        respond_to do |format|
          format.html {redirect_to admin_users_path, notice: "User was successfully created"}
        end
      else
        @hobbies = Hobby.select(:id, :name)
        @breadcrumbs = {"User" => admin_users_path, "New" => nil}

        render :new
      end
    end
  end

  def edit
    @breadcrumbs = {"User" => admin_users_path, "Edit" => nil}
    @hobbies = Hobby.select(:id, :name)
  end

  def update
    ActiveRecord::Base.transaction do
      if @user.update user_params
        update_user_target @user, "hobbies"

        respond_to do |format|
          format.html {redirect_to admin_users_path, notice: "User was successfully created"}
        end
      else
        @hobbies = Hobby.select(:id, :name)
        @breadcrumbs = {"User" => admin_users_path, "Edit" => nil}

        render :edit
      end
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User was successfully deleted"
    else
      flash[:danger] = "User not deleted"
    end

    respond_to do |format|
      format.html {redirect_to admin_users_path}
    end
  end

  private

  def user_params
    if params[:user][:password].blank?
      params.require(:user).permit(:email, :role,
                                   profile_attributes: [:id, :full_name, :avatar, :gender, :birthday, :description])
    else
      params.require(:user).permit(:email, :password, :password_confirmation, :role,
                                   profile_attributes: [:id, :full_name, :avatar, :gender, :birthday, :description])
    end
  end

  def find_user
    @user = User.find_by_id params[:id]
    redirect_to admin_users_path, flash: {danger: "User not found"} unless @user
  end

  def update_user_target user, target
    target_ids = params[:user]["#{target.singularize}_ids".to_sym].select {|id| id.present?}
    return unless target_ids.present?
    user.send("user_#{target}").where.not("#{target.singularize}_id": target_ids).delete_all
    target_ids.each do |target_id|
      user.send("user_#{target}").find_or_create_by("#{target.singularize}_id": target_id)
    end
  end
end
