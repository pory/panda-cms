require 'rest-client'
require 'json'

class Text
  DOCUMENT_DB = AppConfig.document_db
  
  def initialize(document, params = {})    
    @document = document
    @data = params
  end
  
  def self.find_or_create document
    begin
      json = RestClient.get("#{DOCUMENT_DB}/#{document}")
      return JSON.parse(json)
    rescue
      RestClient.put "#{DOCUMENT_DB}/#{document}", '{}', :content_type => :json
      return {}
    end  
  end
  
  def save
    old_data = Text.find_or_create(@document)
    RestClient.put "#{DOCUMENT_DB}/#{@document}", old_data.merge(@data).to_json, :content_type => :json
  end  
  
end