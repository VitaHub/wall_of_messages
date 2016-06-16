module ApplicationHelper

=begin
  def resource
    instance_variable_get(:"@#{resource_name}")
  end

  def resource
    @resource ||= User.new
  end
=end

  def resource_name
    devise_mapping.name
  end
  alias :scope_name :resource_name

  def resource_class
    devise_mapping.to
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
