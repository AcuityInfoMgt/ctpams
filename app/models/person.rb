class Person < ActiveRecord::Base
  belongs_to :personable, polymorphic: true
end
