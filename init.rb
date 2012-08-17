require 'redmine'

Redmine::Plugin.register :redmine_custom_menu do
  name 'Redmine Custom Menu plugin'
  author 'Paweł Jędrzejczyk'
  description 'This plugin allows to create custom menu items in Redmine'
  version '0.0.1'
  url 'http://budikom.net'
  author_url 'http://budikom.net'
  
  links = Link.find(:all)
  links.each {|link|
    if link.new_window then
      Redmine::MenuManager.map(:top_menu).push link.name.to_sym, link.url, { :last => true, :html => { :target => '_blank' }, :caption => link.name } unless Redmine::MenuManager.map(:top_menu).exists?(link.name.to_sym)
    else
      Redmine::MenuManager.map(:top_menu).push link.name.to_sym, link.url, { :last => true, :caption => link.name } unless Redmine::MenuManager.map(:top_menu).exists?(link.name.to_sym)
    end
  } 
  
  menu :admin_menu, :custom_menu, { :controller => 'links', :action => 'index' }, { :last => true, :caption => :links, :html => { :class => 'icon-folder' } }

end