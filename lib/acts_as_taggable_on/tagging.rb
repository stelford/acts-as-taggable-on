module ActsAsTaggableOn
  class Tagging < ::ActiveRecord::Base #:nodoc:
    establish_connection "other_#{Rails.env}" 
    #establish_connection "other_#{Rails.env}" if Rails.configuration.database_configuration.has_key? "other_#{Rails.env}"
    include ActsAsTaggableOn::ActiveRecord::Backports if ::ActiveRecord::VERSION::MAJOR < 3

    attr_accessible :tag,
                    :tag_id,
                    :context,
                    :taggable,
                    :taggable_type,
                    :taggable_id,
                    :tagger,
                    :tagger_type,
                    :tagger_id

    belongs_to :tag, :class_name => 'ActsAsTaggableOn::Tag'
    belongs_to :taggable, :polymorphic => true
    belongs_to :tagger,   :polymorphic => true

    validates_presence_of :context
    validates_presence_of :tag_id

    validates_uniqueness_of :tag_id, :scope => [ :taggable_type, :taggable_id, :context, :tagger_id, :tagger_type ]
  end
end