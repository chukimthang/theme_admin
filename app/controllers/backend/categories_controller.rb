class Backend::CategoriesController < Backend::BaseController
  authorize_resource

  before_action :find_group
  before_action :find_category, only: [:edit, :update, :destroy]

  def index
    @breadcrumbs = {"Group" => admin_groups_path, "Category" => admin_group_categories_path, "List" => nil}
    @categories = @group.categories.where(parent_id: nil).page(params[:page]).per(CONSTANT::PAGE_SIZE)
  end

  def new
    @breadcrumbs = {"Group" => admin_groups_path, "Category" => admin_group_categories_path, "New" => nil}
    @category = Category.new
    list_parent_category
  end

  def create
    @category = @group.categories.new category_params
    if @category.save
      respond_to do |format|
        format.html {redirect_to admin_group_categories_path, notice: "Category was successfully created"}
      end
    else
      @breadcrumbs = {"Group" => admin_groups_path, "Category" => admin_group_categories_path, "New" => nil}
      list_parent_category
      render :new
    end
  end

  def edit
    @breadcrumbs = {"Group" => admin_groups_path, "Category" => admin_group_categories_path, "Edit" => nil}
    list_parent_category
  end

  def update
    if @category.update_attributes category_params
      respond_to do |format|
        format.html {redirect_to admin_group_categories_path, notice: "Category was successfully updated"}
      end
    else
      @breadcrumbs = {"Group" => admin_groups_path, "Category" => admin_group_categories_path, "Edit" => nil}
      list_parent_category
      render :edit
    end
  end

  def destroy
    ancestors = @category.get_ancestors
    ancestors.each do |ancestor|
      ancestor[1].destroy
    end

    respond_to do |format|
      format.html {redirect_to admin_group_categories_path, notice: "Category was successfully deleted"}
    end
  end

  private

  def find_group
    @group = Group.find_by_id params[:group_id]
  end

  def find_category
    @category = @group.categories.find_by_id params[:id]
    redirect_to admin_group_categories_path, flash: {danger: "Category not found"} unless @category
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end

  def list_parent_category
    @list_category = @group.categories.where(parent_id: nil).select(:id, :name, :parent_id)
  end
end
