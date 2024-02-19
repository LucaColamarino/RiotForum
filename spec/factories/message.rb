FactoryBot.define do
    factory :message do
      receiver_id {1}
      sender_id {2}
      subject { 'Messaggio di prova' }
      body { 'Messaggio di prova' }
      receive_email {'test@example.com'}
      id {1}
      # Altri attributi dell'utente, se necessario
    end

  end