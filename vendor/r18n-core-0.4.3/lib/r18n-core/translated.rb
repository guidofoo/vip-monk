# encoding: utf-8
=begin
Add i18n support to any class.

Copyright (C) 2008 Andrey “A.I.” Sitnik <andrey@sitnik.ru>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
=end

module R18n
  # Module to add i18n support to any class. It will be useful for ORM or
  # R18n plugin with out-of-box i18n support.
  # 
  # Module can add proxy-methods to find translation in object methods. For
  # example, if you class have +title_en+ and +title_ru+ methods, you can add
  # proxy-method +title+, which will use +title_ru+ for Russian users and
  # +title_en+ for English:
  # 
  #   require 'r18n-core/translated'
  #   
  #   class Product
  #     include DataMapper::Resource
  #     property :title_ru, String
  #     property :title_en, String
  #     property :desciption_ru, String
  #     property :desciption_en, String
  #     
  #     include R18n::Translated
  #     translations :title, :desciption
  #   end
  #   
  #   # User know only Russian
  #   R18n.set(R18n::I18n.new('ru'))
  #   
  #   product.title #=> Untranslated
  #   
  #   # Set value to English (default) title
  #   product.title_en = "Anthrax"
  #   product.title #=> "Anthrax"
  #   product.title.locale #=> Locale en (English)
  #   
  #   # Set value to title on user locale (Russian)
  #   product.title = "Сибирская язва"
  #   product.title #=> "Сибирская язва"
  #   product.title.locale #=> Locale ru (Russian)
  #   
  #   product.title_en #=> "Anthrax"
  #   product.title_ru #=> "Сибирская язва"
  # 
  # Proxy-method support all funtion from I18n: global and type filters,
  # pluralization, variables. It also return TranslatedString or Untranslated.
  #
  # Note, you must set your I18n object by <tt>R18n.set</tt> and don’t forget
  # to require <tt>'r18n-core/translated'</tt>. R18n plugins (sinatra-r18n,
  # r18-desktop) set I18n object by <tt>R18n.set</tt> automatically, but you
  # must call <tt>i18n</tt> helper in Sinatra before use models.
  #
  # See R18n::Translated::Base for class method documentation.
  # 
  # == Options
  # You can set option for proxy-method as Hash with keys;
  # * +type+ – YAML type for filters. For example, "markdown" or "escape_html".
  # * +methods+ – manual method map as Hash of locale codes to method names.
  # * +no_params+ – set it to true if you proxy-method must send it parameters
  #   only to filters.
  # * +no_write+ – set it to true if you don’t want to create proxy-setters.
  # 
  # Method +translation+ will be more useful for options:
  # 
  #   translation :title, :methods => {:ru => :russian, :en => :english}
  module Translated
    class << self
      def included(base) #:nodoc:
        base.send :extend, Base
        base.instance_variable_set '@unlocalized_getters', {}
        base.instance_variable_set '@unlocalized_setters', {}
        base.instance_variable_set '@translation_types', {}
      end
    end
    
    # Module with class methods, which be added after R18n::Translated include.
    module Base
      # Hash of translation method names to it type for filters.
      attr_reader :translation_types
      
      # Add several proxy +methods+. See R18n::Translated for description.
      # It’s more compact, that +translation+.
      # 
      #   translations :title, :keywords, [:desciption, {:type => 'markdown'}]
      def translations(*methods)
        methods.each do |method|
          translation(*method)
        end
      end
      
      # Add proxy-method +name+. See R18n::Translated for description.
      # It’s more useful to set options.
      # 
      #   translation :desciption, :type => 'markdown'
      def translation(name, options = {})
        if options[:methods]
          @unlocalized_getters[name] = R18n::Utils.hash_map(options[:methods]) { |l, i| [ l.to_s, i.to_s ] }
          unless options[:no_write]
            @unlocalized_setters[name] =R18n::Utils.hash_map(options[:methods]) { |l, i| [ l.to_s, i.to_s + '=' ] }
          end
        end
        
        @translation_types[name] = options[:type]
        call = options[:no_params] ? 'call' : 'call(*params)'
        
        class_eval <<-EOS, __FILE__, __LINE__
          def #{name}(*params)
            unlocalized = self.class.unlocalized_getters(#{name.inspect})
            R18n.get.locales.each do |locale|
              code = locale.code
              next unless unlocalized.has_key? code
              result = method(unlocalized[code]).#{call}
              next unless result
              
              path = "\#{self.class.name}##{name}"
              type = self.class.translation_types[#{name.inspect}]
              if type
                return R18n::Filters.process(R18n::Filters.enabled,
                         type, result, locale, path, params)
              else
                result = TranslatedString.new(result, locale, path)
                return R18n::Filters.process_string(R18n::Filters.enabled,
                         result, path, params)
              end
            end
            
            R18n::Untranslated.new("\#{self.class.name}\#", '#{name}',
                                   R18n.get.locale)
          end
        EOS
        
        unless options[:no_write]
          class_eval <<-EOS, __FILE__, __LINE__
            def #{name}=(*params)
              unlocalized = self.class.unlocalized_setters(#{name.inspect})
              R18n.get.locales.each do |locale|
                code = locale.code
                next unless unlocalized.has_key? code
                return method(unlocalized[code]).call(*params)
              end
            end
          EOS
        end
      end

      # Return Hash of locale code to getter method for proxy +method+. If you
      # didn’t set map in +translation+ option +methods+, it will be detect
      # automatically.
      def unlocalized_getters(method)
        matcher = Regexp.new('^' + Regexp.escape(method.to_s) + '_(.*[^=])$')
        unless @unlocalized_getters.has_key? method
          @unlocalized_getters[method] = {}
          self.instance_methods.reject { |i| not i =~ matcher }.each do |i|
            @unlocalized_getters[method][i.to_s.match(matcher)[1]] = i.to_s
          end
        end
        @unlocalized_getters[method]
      end
      
      # Return Hash of locale code to setter method for proxy +method+. If you
      # didn’t set map in +translation+ option +methods+, it will be detect
      # automatically.
      def unlocalized_setters(method)
        matcher = Regexp.new('^' + Regexp.escape(method.to_s) + '_(.*)=$')
        unless @unlocalized_setters.has_key? method
          @unlocalized_setters[method] = {}
          self.instance_methods.reject { |i| not i =~ matcher }.each do |i|
            @unlocalized_setters[method][i.to_s.match(matcher)[1]] = i.to_s
          end
        end
        @unlocalized_setters[method]
      end
    end
  end
end