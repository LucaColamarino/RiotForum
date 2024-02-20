require 'rails_helper'


RSpec.describe Message, type: :model do
    describe "unit test messaggi" do
        let(:user) {create(:user)}
        let(:user1) {create(:user1)}
        before {user.add_role(:moderator)}

        it "invia messaggio con campi validi" do
            message=Message.new(subject:"Prova",body:"Prova",sender_id:user.id,receiver_id:user1.id)
            expect(message).to be_valid
        end

        it "non invia messaggio senza receiver" do
            message=Message.new(subject:"Prova",body:"Prova",sender_id:user.id)
            expect(message).not_to be_valid
        end

        it 'non invia messaggio senza sender' do
            message=Message.new(subject:"Prova",body:"Prova",receiver_id:user1.id)
            expect(message).not_to be_valid
        end
        it 'non invia messaggio senza subject' do
            message=Message.new(subject:"",body:"Prova",sender_id:user.id,receiver_id:user1.id)
            expect(message).not_to be_valid
        end
        it ' non invia messaggio senza body' do
            message=Message.new(subject:"Prova",body:"",sender_id:user.id,receiver_id:user1.id)
            expect(message).not_to be_valid
        end






    end
end