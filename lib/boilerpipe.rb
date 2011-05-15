require 'open-uri'

class Object
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
  
  def present?
    !blank?
  end
end

module Boilerpipe
  BP_DEFAULT_API_URL = 'http://boilerpipe-web.appspot.com/extract'
  BP_EXTRACTORS = [ :ArticleExtractor, :DefaultExtractor, :LargestContentExtractor, :KeepEverythingExtractor, :CanolaExtractor ]
  BP_OUTPUT_FORMATS =  [ :html, :htmlFragment, :text, :json, :debug ]
  
  def self.extract(extract_url, opts = {})
    @output    = opts[:output].present?     ? opts[:output]     : BP_OUTPUT_FORMATS.first
    @extractor = opts[:extractor].present?  ? opts[:extractor]  : BP_EXTRACTORS.first 
    @api       = opts[:api].present?        ? opts[:api]        : BP_DEFAULT_API_URL
    
    url = [@api, "?url=#{extract_url}", "&extractor=#{@extractor}","&output=#{@output}"].join
    open(url).read
  end
end
