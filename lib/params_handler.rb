module ParamsHandler

  protected

  EMPTY_PARAMS = [nil, '', 'null', 'undefined']

  def empty_param? key
    key.blank? || EMPTY_PARAMS.include?(params[key].to_s.strip)
  end

  def param? key
    not empty_param?(key)
  end
  alias_method :valid_param?, :param?

  def param_object? key
    if obj = get_param(key)
      obj.is_a?(Hash) && obj.values?
    end
    false
  end

  def get_param key
    empty_param?(key) ? nil : params[key].strip
  end

  def get_params *keys
    keys.inject({}){|hash, key| hash[key.to_sym] = get_param(key) if valid_param?(key); hash}
  end

  def param
    Hashie::Mash.new(params)  #OpenStruct.new({:to_a => params.values}.merge(get_params(*params.keys)))
  end

  # Cookies --------------------------------------------------
  def cookie? key
    key.present? && valid?(cookies[key.to_sym])
  end
  alias_method :valid_cookie?, :cookie?

  def empty_cookie? key
    not valid_cookie?(key)
  end

  def get_cookie key
    empty_cookie?(key) ? nil : cookies[key.to_sym]
  end

  def get_cookies *keys
    keys.inject({}){|hash, key| hash[key.to_sym] = get_cookie(key) if cookie?(key); hash}
  end

  def set_cookie key, value, expires=1.years.from_now
    return unless key.present? && valid?(value)
    cookies[key.to_sym] = { :value => value, :expires => expires }
  end

  def cookie
    Hashie::Mash.new(cookies)  #OpenStruct.new({:to_a => cookies.values}.merge(get_cookies(*cookies.keys)))
  end

  def valid? val
    val.to_s.strip.present?
  end

end
