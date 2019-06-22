module API
  module V1
    module Resources
      class Users < Grape::API
        resource :users do
          desc 'Create an user'

          params do
            requires :name,
                     type: String,
                     desc: 'The name of the user'
          end
          post do
            user = User.create!(name: params[:name])
            present user, with: Entities::User
          end

          params do
            requires :id, type: Integer, desc: 'User id.'
          end
          route_param :id do
            desc 'Get specific user profile'
            get do
              user = User.find(params[:id])
              present user, with: Entities::User
            end

            resource :check_in do
              desc 'Will go to bed'
              post do
                user = User.find(params[:id])
                sleep_record = SleepTracker.check_in(user)
                present sleep_record, with: Entities::SleepingRecord
              end
            end

            resource :check_out do
              desc 'Woke up from bed'
              post do
                user = User.find(params[:id])
                sleep_record = SleepTracker.check_out(user)
                present sleep_record, with: Entities::SleepingRecord
              end
            end

            resource :follow do
              desc 'User can follow another user'

              params do
                requires :followed_user_id,
                         type: Integer,
                         desc: 'The id of the user being followed'
              end
              post do
                user = User.find(params[:id])
                following_user = User.find(params[:followed_user_id])
                user.following << following_user unless user.following.include?(following_user)
                present user, with: Entities::User
              end
            end

            resource :unfollow do
              desc 'User can unfollow a user'

              params do
                requires :followed_user_id,
                         type: Integer,
                         desc: 'The id of the user being unfollowed'
              end
              post do
                user = User.find(params[:id])
                following_user = User.find(params[:followed_user_id])
                user.following.delete(following_user)
                present user, with: Entities::User
              end
            end

            resource :friends do
              desc 'List all his friends and their weekly sleeping records'

              get do
                user = User.find(params[:id])
                present user.friends, with: Entities::Friend
              end
            end
          end
        end
      end
    end
  end
end
