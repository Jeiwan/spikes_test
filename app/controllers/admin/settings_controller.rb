class Admin::SettingsController < ApplicationController
  respond_to :js

  authorize_resource

  def set_threshold
    if params[:threshold]
      Admin::Setting.find_or_create_by(name: "quantity_threshold").update(value: params[:threshold].to_s)
    end
  end
end
