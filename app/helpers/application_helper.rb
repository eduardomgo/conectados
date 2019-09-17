module ApplicationHelper
    def friendships(u1)
        friend_asks = Friend.where(asker_id: u1.id, accepted: false)
        f1 = Friend.where(asker_id: u1.id, accepted: true)
        friends1 = []
        f1.each do |f|
            friends1.push([f.replyer.name, f.replyer_id])
        end

        f2 = Friend.where(replyer: u1.id, accepted: true)
        friends2 = []
        f2.each do |f|
            friends2.push(f.asker.name)
        end

        @friends = []
        friends1.each do |f|
            if f[0].in?(friends2)
                @friends.push(f)
            end
        end
        return @friends
    end
    
    def block_non_logged #por algum motivo essa função não estava sendo herdada no application helper
        if !user_signed_in?
            redirect_to new_user_session
        end
    end
end
