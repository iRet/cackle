class CackleComment < ActiveRecord::Base
  self.primary_key = 'comment_id'
  default_scope       { order('created_at DESC') }
  scope :approved, -> { where(status: 'approved') }
end