module Main::Helpers
  module URL
    def url(*args)
      "/" + args.map(&:to_param).join("/")
    end
  end
end

Main.helpers do
  include Main::Helpers::URL
end
