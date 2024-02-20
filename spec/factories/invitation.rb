FactoryBot.define do
    factory :invitation30, class: 'Invitation' do
      user_id {30}
      friend_id {2}
      confirmed {false}
    end
end