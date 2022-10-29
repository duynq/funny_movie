class EmailValidator < ActiveModel::EachValidator
  VERIFICATION_VALUE = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def validate_each(record, attr_name, value)
    return unless value.present? && value !~ VERIFICATION_VALUE

    record.errors.add(attr_name, :invalid)
  end
end
