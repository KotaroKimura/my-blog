require 'hanami/validations'

module Concerns
  module Validatable
    def self.included(klass)
      _v_class = klass.const_set :'Validation', Class.new
      _v_class.class_eval do
        include Hanami::Validations
      end
    end

    private

    def valid?
      validate_result = self.class::Validation.new(@params).validate

      if validate_result.messages.empty?
        true
      else
        add_errors(validate_result)
        false
      end
    end

    def add_errors validate_result
      validate_result.messages.each do |k, v|
        v.each do |m|
          error("#{k} #{m}.")
        end
      end
    end
  end
end