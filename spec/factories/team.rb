FactoryBot.define do

    factory :team0 do

        leader_id {  }
        mode { 'Normal' }
        lanes {[ "Top", "Mid", "Support" ]}
        comp { { "Top" =>  8, "Mid" => 9, "Support" => 10 } }
        minRank { "Iron" }
        id { 1 }
    end

    factory :team1 do

        leader_id {  }
        mode { 'Normal' }
        lanes {[ "Top", "Mid", "Support" ]}
        comp { { "Top" =>  8, "Mid" => 9, "Support" => 10 } }
        minRank { "Iron" }
        id { 2 }
    end

  end
  