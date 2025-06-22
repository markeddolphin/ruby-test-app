class CsvImportService

    require 'csv'
    
    def initialize(file)
      @file = file
      @count = 0
    end

    def import
        CSV.foreach(@file.path, headers: true) do |row|
        product_id = row["product"].to_i
        product = Product.find_by(id: product_id)

        # Create a new product if it doesn't exist
        unless product
            product = Product.create(name: row["product"])
        end

        Feedback.create!(
            product_id: product.id,
            rating: row["rating"]
        )
    end        
    end
    
end