module LocationAddress
  def address
    [street, city, state, country].compact_blank.join(", ")
  end
end