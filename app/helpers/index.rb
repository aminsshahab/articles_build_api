helpers do

  def increase_counter(api_key)
   Key.find_by(api_key: api_key).increment_counter(:count, 1)
  end

  def api_key_nil?(api_key)
    api_key.nil?
  end

end
