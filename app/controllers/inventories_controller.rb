class InventoriesController < ApplicationController
    def new
        @inventory = Inventory.new
    end

    def create
        @inventory = Inventory.new(strong_params)
        @existing_inventory = Inventory.find_by(store_id: params[:inventory][:store_id], product_id: params[:inventory][:product_id])

        if @inventory.valid? && !!@existing_inventory[:quantity]
            @inventory.save
            @existing_inventory.increase_quantity(@inventory.quantity)
            redirect_to product_path(@inventory.product_id)
        else
            #error message stuff here
            #need to make custom error messages for !!@inventory[:quantity]
                #and @inventory[:quantity] > 0
            render :new
            #redirect_to(new_purchase_path)
        end
    end

    def edit
    end

    def update
    end

    private
    def strong_params
        params.require(:inventory).permit(:store_id, :product_id, :quantity)
    end
end
