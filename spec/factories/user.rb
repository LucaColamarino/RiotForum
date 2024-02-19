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

    factory :user30, class: 'User' do
      email { 'user30@example.com' }
      password { 'password' }
      username { 'aristotele' }
      # Altri attributi dell'utente1, se necessario
    end

    factory :user31, class: 'User' do
      email { 'user31@example.com' }
      password { 'password' }
      username { 'DavideTank' }
      # Altri attributi dell'utente1, se necessario
    end

    factory :looper90, class: 'User' do
      email { 'looper90@example.com' }
      password { 'password' }
      username { 'Looper90' }
      # Altri attributi dell'utente1, se necessario
    end

    factory :sithscorpion, class: 'User' do
      email { 'sithscorpion@example.com' }
      password { 'password' }
      username { 'sithscorpion' }
      # Altri attributi dell'utente1, se necessario
    end

  end
  