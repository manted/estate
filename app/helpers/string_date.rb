module StringDate
  def date_from_string(date_string)
    if date_string.present?
      values = date_string.split("/")
      if values.size == 3
        Date.new(values[2].to_i, values[1].to_i, values[0].to_i)
      else
        Date.new(values[1].to_i, values[0].to_i, 1)
      end
    else
      nil
    end
  end

  def string_from_date(date)
    if date.present?
      "#{date.day}/#{date.month}/#{date.year}"
    else
      ""
    end
  end
end