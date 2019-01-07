class Backend::GroupsController < Backend::BaseController
  authorize_resource

  skip_before_action :verify_authenticity_token
  before_action :find_group, only: [:edit, :update, :destroy]

  def index
    @breadcrumbs = {"Group" => admin_groups_path, "List" => nil}
    @groups = current_user.groups.without_deleted.order(:name).page(params[:page]).per(CONSTANT::PAGE_SIZE)
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.new group_params

    if @group.save
      flash[:success] = "Group was successfully created"

      respond_to do |format|
        format.json {render json: {status: true}}
      end
    else
      @errors = @group.errors.messages

      respond_to do |format|
        format.json {render json: {status: false, errors: @errors}}
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @group.update group_params
      flash[:success] = "Group was successfully updated"

      respond_to do |format|
        format.json {render json: {status: true}}
      end
    else
      @errors = @group.errors.messages

      respond_to do |format|
        format.json {render json: {status: false, errors: @errors}}
      end
    end
  end

  def destroy
    if @group.destroy
      flash[:success] = "Group was successfully deleted"
    else
      flash[:danger] = "Group not deleted"
    end

    respond_to do |format|
      format.html {redirect_to admin_groups_path}
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def find_group
    @group = current_user.groups.find_by_id params[:id]
    redirect_to admin_groups_path, flash: {danger: "Group not found"} unless @group
  end
end
