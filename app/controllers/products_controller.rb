
class ProductsController < ApplicationController
    def index
        @products = Product.all
        @product = Product.new

        if params[:name].present?
            @products = @products.where("name LIKE ?", "%#{params[:name]}%")
        end

        if params[:rating].present?
            @products = @products.joins(:feedbacks)
                                .group("products.id")
                                .having("AVG(feedbacks.rating) >= ? AND AVG(feedbacks.rating) < ?", params[:rating].to_f, params[:rating].to_f+1)
        end

        if turbo_frame_request?
            render partial: "products", locals: {products: @products}
        else
            render :index
        end
        
    end
    
    def edit
        @product = Product.find(params[:id])
    end
    
    def create
        @product = Product.new(product_params)
        
        respond_to do |format|
            if @product.save
                format.html { redirect_to products_url, notice: "Product was successfully created" }
            else
                format.html { render :new, status: :unprocessable_entity }
            end
        end
    end
    
    def import_csv
        if params[:file].present?
            file = params[:file]

            csvImportService = CsvImportService.new(file)
            csvImportService.import
            
            redirect_to products_path, notice: "CSV imported successfully."
        else
            redirect_to products_path, alert: "Please choose a CSV file."
        end
    end

    def search
        @products = Product.all

        if params[:name].present?
            @products = @products.where("name LIKE ?", "%#{params[:name]}%")
        end

        if params[:rating].present?
            @products = @products.joins(:feedbacks)
                                .group("products.id")
                                .having("AVG(feedbacks.rating) = ?", params[:rating].to_f)
        end

        respond_to do |format|
            format.turbo_stream
        end
    end

    private

    def product_params
        params.require(:product).permit(:name)
    end
    
end
