module TransactionsHelper
  def update_buget transaction, old_amount
    total_expense = transaction.group.total_buget + old_amount - transaction.amount
    total_income = transaction.group.total_buget - old_amount + transaction.amount
    total_buget = transaction.expense? ? total_expense : total_income
    transaction.group.update_attributes(total_buget: total_buget)
  end
end
