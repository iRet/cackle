require 'open-uri'

namespace :cackle do

  def say text
    if Rails.env.development?
      puts text
    end
  end

  def build_path
    begin
      config = YAML::load(File.open('config/cackle.yml'))
    rescue Errno::ENOENT
      fail 'Create config/cackle.yml first'
    end
    say 'Will use: '
    say config['site_id']
    say config['site_api_key']
    say config['account_api_key']
    "http://cackle.me/api/comment/mutable_list?siteApiKey=#{config['site_api_key']}&accountApiKey=#{config['account_api_key']}"
  end

  def create_comment c
    comment = CackleComment.new(
      comment_id: c['id'],
      parent_id:  c['parentId'],
      post_id:    c['channel'], 
      url:        c['url'],
      title:      c['title'],
      message:    c['message'],
      status:     c['status'],
      ip:         c['ip'], 
      created_at: Time.strptime((c['created']/1000).to_s, "%s"),
      updated_at: Time.strptime(c['modified'][0..9], "%s"))
    if c['author'] 
      comment.author_name     = c['author']['name']
      comment.author_email    = c['author']['email']
      comment.author_www      = c['author']['www']
      comment.author_avatar   = c['author']['avatar']
      comment.author_provider = c['author']['provider']
    else
      comment.anonym_name     = c['anonym']['name']
      comment.anonym_email    = c['anonym']['email']
    end
    if comment.save
      say "created #{comment.comment_id}"
    end
  end

  desc 'Initial comment base load'
  task import: :environment do
    CackleComment.delete_all
    path = build_config
    begin 
      max      = CackleComment.maximum('created_at')
      url     = max ? path + "&modified=#{max.to_i*1000}" : path
      response = open(url).read
      json     = JSON.parse(response)
      comments = json['comments']
      comments.each do |c|
        create_comment c
      end
    end while (comments.size == 100)
    say "Total #{CackleComment.count} in base"
  end

  desc 'Synchronize comments database'
  task fetch: :environment do
    path = build_path
    max = CackleComment.maximum('updated_at')

    fail 'run cackle:import first' unless max

    say "maximum found in base: #{max}"
    url = path + "&modified=#{max.to_i*1000}"

    response = open(url).read
    json     = JSON.parse(response)

    json['comments'].each do |c|
      comment = CackleComment.find_by_comment_id(c['id'])
      if comment
        if (time = Time.strptime((c['modified'][0..9]).to_s, "%s")) > comment.updated_at
          say "updating: #{c['id']}"
          comment.update_attributes(
            message:    c['message'],
            status:     c['status'],
            updated_at: time)
          comment.save
        else
          say "comment: #{c['id']} already exist"
        end
      else
        create_comment c
      end
    end
  end
end
