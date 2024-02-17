module TeamsHelper

    def has_team(user)

        not user.team_id.nil?
    end
end
