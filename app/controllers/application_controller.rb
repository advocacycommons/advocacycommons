class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_paper_trail_whodunnit
  helper_method :current_group, :current_role

  def current_user
    current_person
  end

  def current_group
    group_id = controller_name == 'groups' ? params[:id] : params[:group_id] 
    Group.find(group_id) if group_id
  end

  def current_role
    Membership.where(
      person_id: current_person.id, group_id: current_group.id
    ).first.role if current_person && current_group
  end

  def validate_admin_permission
    return if controller_name == 'sessions' || current_person.nil?
    render_not_found unless current_person.admin?
  end

  def after_sign_in_path_for(resource)
    if session[:redirect_uri]
      session[:redirect_uri]
    elsif resource.admin?
      admin_dashboard_path
    elsif can? :manage, current_group
      group_dashboard_path(current_group.id)
    else
      profile_index_path
    end
  end

  def authorize_group_access
    if params[:group_id]
      @group =  Group.find_by(id: params[:group_id])
      authorize! :manage, @group
    else
      true
    end
  end


  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html do
        flash[:alert] = "Access denied. You are not authorized to access the requested page."
        redirect_to profile_index_path
      end
      format.json { head :forbidden }
    end
  end

  private

  def render_not_found
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404", layout: false, status: :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, current_group)
  end

  def json_request?
    request.format.json?
  end

  def direction_param
    @direction_param ||= ['asc', 'desc'].include?(params[:direction]) && params[:direction] || nil
  end
end
