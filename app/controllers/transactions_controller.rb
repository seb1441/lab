class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /transactions
  # GET /transactions.json
  def index
    @months = Date::MONTHNAMES.compact
    @years = (2018..2030).to_a
    @current_month = params[:month] || @months[Time.now.month - 1]
    @current_year = params[:year] || Time.now.year
    # @transactions = Transaction.order(date: :desc)
    @transactions = Transaction.where('extract(month from date) = ?', @months.index(@current_month) + 1)
      .where('extract(year from date) = ?', @current_year.to_i)
      .order('date DESC')
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
    @page_title = "Transaction"
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    @transaction.user = current_user

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transactions_path, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transactions_path, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def statistics
    @months = Date::MONTHNAMES.compact
    @years = (2018..2030).to_a
    @current_month = params[:month] || @months[Time.now.month - 1]
    @current_year = params[:year] || Time.now.year

    transactions = Transaction.where('extract(month from date) = ?', @months.index(@current_month) + 1)
      .where('extract(year from date) = ?', @current_year.to_i)
    @categories = []

    @chart_total = Transaction.all.group_by {|t| t.date.beginning_of_month }.map { |m| [m.first.strftime("%B %Y"), m.second.sum(&:price).to_f] }
    @chart_categories = transactions.group_by {|t| t.category }.map {|t| [t.first.title, t.second.sum(&:price).to_f] }

    return unless transactions.any?
    users = User.all


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

    # @users.each do |u|
    #   # instance_variable_set("@#{u.username)}".to_sym)
    #     instance_variable_set("@#{u.username.downcase}_spent", @transactions.where(user: u).sum(:price))
    # end
    # @yuki_spent = Transaction.where(user: User.find_by(us)).sum(:price)
    # @seb_spent = Transaction.all.sum(:price)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:date, :user, :description, :price, :category, :category_id)
    end
end
