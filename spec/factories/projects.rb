FactoryGirl.define do
  factory :project do
    name "MyString"
description "MyText"
start_date "2015-03-16"
end_date "2015-03-16"
budget_requested 1
fiscal_year 1
objective "MyText"
interest "MyText"
law_enforcement "MyText"
coordination "MyText"
lessons_learned "MyText"
sustainability "MyText"
city_province "MyString"
program_audience "MyString"
reprogram false
reprogram_comments "MyText"
implementation_status 1
program_id 1
user_id 1
is_archived false
is_denied false
is_active false
  end

end
