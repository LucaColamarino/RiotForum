FactoryBot.define do

    factory :team0, class: 'Team' do

        leader_id { 2 }  #user1
        #leader_lane { "Mid"}
        mode { 'Normal' }
        lanes {[ "Top" ]}
        #comp { { "Top" =>  8, "Mid" => 2 } }  #user8
        minRank { "Iron" }
        id { 1 }
    end

    factory :team1, class: 'Team' do

        leader_id {  }
        mode { 'Normal' }
        lanes {[ "Top", "Mid", "Support" ]}
        comp { { "Top" =>  8, "Mid" => 9, "Support" => 10 } }
        minRank { "Iron" }
        id { 2 }
    end

  end
  