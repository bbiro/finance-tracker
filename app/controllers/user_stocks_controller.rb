class UserStocksController < ApplicationController

    def create
        begin
            stock = Stock.check_db(params[:ticker])
            if (stock.blank?)
                stock = Stock.new_lookup(params[:ticker])
                stock.save!
            end
        rescue StandardError => e
            flash.now[:alert] = "Stock couldn't be added. #{e.to_s}"
            # Show old stocks
            @tracked_stocks = current_user.stocks
            respond_to do |format|
                format.js { render partial: 'stocks/list'}
            end
            return
        end

        if stock
            @user_stock = UserStock.create(user: current_user, stock: stock)
            flash.now[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
            list_tracked_stocks_remote
        end
    end

    def destroy
        stock = Stock.find(params[:id])
        user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
        user_stock.destroy

        flash.now[:notice] = "#{stock.ticker} was successfully removed from your list."
        list_tracked_stocks_remote
    end

    def list_tracked_stocks_remote
        @tracked_stocks = current_user.stocks

        respond_to do |format|
            format.js { render partial: 'stocks/list'}
        end
    end
end
