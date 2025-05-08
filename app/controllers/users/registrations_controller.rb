# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    # 入力された会社名で会社を探す or 作成
    company = Company.find_or_create_by(name: resource.company_name)
    resource.company = company

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
end
