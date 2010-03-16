class Main
  helpers do

    # Your helpers go here. You can also create another file in app/helpers with the same format.
    # All helpers defined here will be available across all the application.
    #
    # @example A helper method for date formatting.
    #
    #   def format_date(date, format = "%d/%m/%Y")
    #     date.strftime(format)
    #   end

    # mock de helper de i18n
    # hasta implementar solucion
    def t(*text)
      "i18n text"
    end

    # idem anterior
    def l(text,format)
      "date/time format"
    end
  end
end
