module ApplicationHelper
    def is_adm(user)
        if user.adm == true
            return true
        end
        return false
    end
end
