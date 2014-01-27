module CackleHelper
  def cackle_comments
    @config ||= YAML::load(File.open('config/cackle.yml'))
    @comments = CackleComment.approved.where("url LIKE ?", "%#{request.path}")
    render template: 'cackle/comments'
  end
  
  def cackle_recent_comments count=10, options={}
    options[:avatar_size] ||= 32
    options[:text_size]   ||= 150
    options[:title_size]  ||= 40
    @comments = CackleComment.approved.limit(count)
    render template: 'cackle/recent', locals: { options: options }
  end
end