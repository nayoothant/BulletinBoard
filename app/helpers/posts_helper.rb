module PostsHelper
    def self.check_header(expected_header,csv_file)
        header = CSV.open(csv_file, 'r') { |csv| csv.first }
        valid_csv = true 
        for i in (0..header.size-1)
          if header[i].downcase != expected_header[i].downcase
            valid_csv = false
          end
        end
      return valid_csv
    end
end
