FactoryBot.define do
    factory :newpost do
      user_id {1}
      title { 'Notizia di prova' }
      content { 'Notizia di prova' }
      # Altri attributi dell'utente, se necessario
    end

  end