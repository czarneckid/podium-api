require 'grape'
require 'json'

module Podium
  class API < Grape::API
    prefix 'api'
    version 'v1'
    default_format :json
    error_format :json
    rescue_from :all

    resource :status do
      get :ping do
        {:status => 'pong'}
      end
    end

    resource :leaderboard do
      params do
        requires :id, :type => String, :desc => 'Member identifier'
        requires :score, :type => Float, :desc => 'Score'
      end
      post :update do
        $highscore_lb.rank_member(params[:id], params[:score])
        {:status => :ok}
      end

      params do
        requires :page, :type => Integer, :desc => 'Leaderboard page'
      end
      get :members do
        members = $highscore_lb.members(params[:page])
        total_pages = $highscore_lb.total_pages
        {:status => :ok, :data => {:members => members, :total_pages => total_pages, :current_page => params[:page]}}
      end

      params do
        requires :id, :type => String, :desc => 'Member identifier'
      end
      get :around_me do
        members = $highscore_lb.around_me(params[:id])
        total_pages = $highscore_lb.total_pages
        {:status => :ok, :data => {:members => members, :total_pages => total_pages, :current_page => $highscore_lb.page_for(params[:id])}}
      end

      delete do
        $highscore_lb.delete_leaderboard
        {:status => :ok}
      end
    end
  end
end