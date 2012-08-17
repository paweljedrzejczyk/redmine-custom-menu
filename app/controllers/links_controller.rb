class LinksController < ApplicationController
  unloadable

  layout 'admin'
  menu_item :custom_menu
  before_filter :require_admin

  def index
    @links = Link.all
  end
  
  def new
    
  end
  
  def create
    Link.create(params[:custom_menu])
    add_link(params[:custom_menu])
    flash[:notice] = l('custom_menu.successful_create')
    redirect_to :action => 'index'
  end
  
  def edit
    @link = Link.find(params[:id])
  end
  
  def update
    @link = Link.find(params[:id])
    update_link(@link, params[:custom_menu])
    if @link.update_attributes params[:custom_menu]
      flash[:notice] = l('custom_menu.successful_update')
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @link = Link.find(params[:id])
    delete_link(@link)
    @link.destroy
    flash[:notice] = l('custom_menu.successful_delete')
    redirect_to :action => 'index'
  end
  
  private
  
  def add_link(link)
    if link[:new_window] then
      Redmine::MenuManager.map(:top_menu).push link[:name].to_sym, link[:url], { :last => true, :html => { :target => '_blank' }, :caption => link[:name] } unless Redmine::MenuManager.map(:top_menu).exists?(link[:name].to_sym)
    else
      Redmine::MenuManager.map(:top_menu).push link[:name].to_sym, link[:url], { :last => true, :caption => link[:name] } unless Redmine::MenuManager.map(:top_menu).exists?(link[:name].to_sym)
    end
  end
  
  def delete_link(link)
    Redmine::MenuManager.map(:top_menu).delete(link.name.to_sym) if Redmine::MenuManager.map(:top_menu).exists?(link.name.to_sym)
  end
  
  def update_link(old_link, new_link)
    delete_link(old_link)
    add_link(new_link)
  end
  
end
