require 'rails_helper'


RSpec.describe Newpost, type: :model do
    describe "unit test notizie" do
        let(:user) {create(:user)}
        before {user.add_role(:moderator)}

        it "newpost nel database con valori validi" do
            newpost=Newpost.new(title:"Titolo", content: "Contenuto")
            expect(newpost.title).to eq("Titolo")
            expect(newpost.content).to eq("Contenuto")
        end
        it "newpost con titolo mancante non valido" do
            newpost=Newpost.new(title:"", content: "Contenuto")
            expect(newpost).not_to be_valid
        end
        it "newpost con contenuto mancante non valido" do
            newpost=Newpost.new(title:"Titolo", content: "")
            expect(newpost).not_to be_valid
        end
        it "controllare se user_id corrisponde all'id dell'utente che crea la notizia" do
            newpost=Newpost.new(title:"Titolo", content: "Contenuto",user_id: user.id)
            expect(newpost.user_id).to eq(user.id)
        end








    end
end
