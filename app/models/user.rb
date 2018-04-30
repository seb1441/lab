class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :transactions
  has_many :todos

  def transactions_by_category(month = Time.now.month)
    # transactions by params[:month]
    transactions = Transaction.where(month: month)
    users = User.all

    @categories = []

    Category.order('title ASC').each do |category|
      obj = {
        color: category.color,
        category: category.title,
        total: transactions.where(category: category).sum(:price),
        users: {}
      }
      # obj_users = {}

      users.each do |user|
        obj[:users][user.username.to_sym] = transactions.where(user: user, category: category).sum(:price)
      end

      # obj[:users]

      @categories.push obj
    end
    @totals = []

    @totals.push transactions.sum(:price)

    users.each do |user|
      @totals.push transactions.where(user: user).sum(:price)
    end
  end
end
