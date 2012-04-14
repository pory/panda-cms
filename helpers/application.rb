# encoding: utf-8
helpers do
  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Not authorized\n"])
    end
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['admin', 'poijqwertz123']
  end
  
  def menu_item(text, description, path, css_class = 'blue')
    request_path = request.path_info
    css_selected_class = request_path.include?(path) ? ' selected' : ''
    css_class += css_selected_class + ' '
    "<a href=\"#{path}\" class=\"#{css_class}\">#{text}<br /><span>#{description}</span>#{yield if defined? yield}</a>"
  end  
  
  def error_message object, attribute
    errors = object.send('errors')
    return "<span class='error'>#{errors[attribute]}</span>" if object.send(attribute)
  end
  
  def list options = {}
    item = options[:item]
    value = options[:object][item].blank? ? "vložte novou hodnotu" : options[:object][item]
    document_id = options[:object]['_id']
    method = options[:object][item].blank? ? 'post' : 'put'    
    if authorized?
      "<img src='/images/icon_pencil.gif' class='edit-icon'><span id='text_item_#{item}' class='editable' data-key='#{item}' data-document_id='#{document_id}' data-method='#{method}'>#{value}</span>"
    else
      options[:object][item] unless options[:object][item].blank?
    end
  end
end