module CackleHelper
  def cackle_comments
    load_config
    @comments = CackleComment.approved.where("url LIKE ?", "%#{request.path}")
    render template: 'cackle/comments'
  end
  
  def cackle_recent_comments
    load_config
    @comments = CackleComment.approved.limit(@config['recent']['mcSize'])
    render template: 'cackle/recent'
  end
  
  private 
  def load_config
    @config ||= YAML::load(File.open('config/cackle.yml'))
  end
end