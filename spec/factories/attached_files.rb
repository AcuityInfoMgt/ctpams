FactoryGirl.define do
  factory :attached_file do
    attachment_type 1
name "MyString"
is_active false
attachable_id 1
attachable_type "MyString"
  end

end
