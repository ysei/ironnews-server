
# APIベース
class ApiBase < ActiveForm
  def self.suppress_parameter(params)
    params = params.dup
    [:controller, :action, :commit, :authenticity_token, :callback].each { |key|
      params.delete(key)
    }
    return params
  end
end