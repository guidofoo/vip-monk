class Main
  helpers do
    def new_line_to_br str
      str.gsub "\n", "<br>"
    end
    
    # Your helpers go here. You can also create another file in app/helpers with the same format.
    # All helpers defined here will be available across all the application.
    #
    # @example A helper method for date formatting.
    #
    #   def format_date(date, format = "%d/%m/%Y")
    #     date.strftime(format)
    #   end
 end
end
