FactoryBot.define do
    factory :user do
      email { 'test@example.com' }
      password { 'password' }
      username {'PippoBaudo'}
      id {1}
      # Altri attributi dell'utente, se necessario
    end
    factory :user1, class: 'User' do
      email { 'user1@example.com' }
      password { 'password' }
      username {'Pierino'}
      id {2}
      # Altri attributi dell'utente1, se necessario
    end

  end
  