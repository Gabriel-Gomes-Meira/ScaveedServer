class NestedAttributeUniqueness < ActiveModel::Validator
  def validate(record)
    new_data = record[:wanted_items].uniq {|x| x[:var_name]}
    if new_data.length != record[:wanted_items].length
      record.errors.add(:wanted_items, "Valor em #{:var_name} deve ser único!")
    end
  end
end