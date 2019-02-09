class Backend::TransactionsController < Backend::BaseController
  authorize_resource

  before_action :find_group
  before_action :find_transaction, only: [:edit, :update, :destroy]

  def index
    @breadcrumbs = {"Transactions" => admin_group_transactions_path, "List" => nil}
    @transactions = @group.transactions.page(params[:page]).per(CONSTANT::PAGE_SIZE)
  end

  def new
    @breadcrumbs = {"Transactions" => admin_group_transactions_path, "New" => nil}
    @transaction = Transaction.new
    list_param
  end

  def create
    @transaction = @group.transactions.new transaction_params
    if @transaction.save
      respond_to do |format|
        format.html {redirect_to admin_group_transactions_path, notice: "Transaction was successfully created"}
      end
    else
      @breadcrumbs = {"Transaction" => admin_group_transactions_path, "New" => nil}
      list_param
      render :new
    end
  end

  def edit
    @breadcrumbs = {"Transactions" => admin_group_transactions_path, "Edit" => nil}
    list_param
  end

  def update
    if @transaction.update_attributes transaction_params
      respond_to do |format|
        format.html {redirect_to admin_group_transactions_path, notice: "Transaction was successfully updated"}
      end
    else
      @breadcrumbs = {"Transaction" => admin_group_transactions_path, "Edit" => nil}
      list_param
      render :edit
    end
  end

  def destroy
    if @transaction.destroy
      flash[:success] = "Transaction was successfully deleted"
    else
      flash[:danger] = "Transaction not deleted"
    end

    respond_to do |format|
      format.html {redirect_to admin_group_transactions_path}
    end
  end

  private

  def find_group
    @group = Group.find_by_id params[:group_id]
  end

  def find_transaction
    @transaction = @group.transactions.find_by_id params[:id]
    redirect_to admin_group_transactions_path, flash: {danger: "Transaction not found"} unless @transaction
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :description, :kind, :category_id)
  end

  def list_param
    @list_category = @group.categories.where(parent_id: nil).select(:id, :name, :parent_id)
  end
end