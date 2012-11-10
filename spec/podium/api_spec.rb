require 'spec_helper'

describe 'Podium::API' do
  def app
    Podium::API
  end

  describe 'status' do
    describe '#ping' do
      it 'should respond with pong' do
        get '/api/v1/status/ping'
        last_response.should be_ok
        JSON.parse(last_response.body)['status'].should == 'pong'
      end
    end
  end

  describe 'leaderboard' do
    it 'should allow you to delete the leaderboard' do
      $highscore_lb.total_members.should == 0
      post '/api/v1/leaderboard/update', :id => 'david', :score => 10000
      $highscore_lb.total_members.should == 1
      delete '/api/v1/leaderboard'
      JSON.parse(last_response.body).tap do |api_response|
        api_response['status'].should == 'ok'
      end
    end

    describe '#update' do
      it 'should update the leaderboard when passed an :id and a :score' do
        $highscore_lb.total_members.should == 0
        post '/api/v1/leaderboard/update', :id => 'david', :score => 10000
        $highscore_lb.total_members.should == 1
        JSON.parse(last_response.body).tap do |api_response|
          api_response['status'].should == 'ok'
        end
      end
    end

    describe '#members' do
      it 'should return a page from the leaderboard' do
        post '/api/v1/leaderboard/update', :id => 'david', :score => 10000
        get '/api/v1/leaderboard/members', :page => 1
        JSON.parse(last_response.body).tap do |api_response|
          api_response['status'].should == 'ok'
          api_response['data']['total_pages'].should == 1
          api_response['data']['current_page'].should == 1
        end
      end
    end

    describe '#around_me' do
      it 'should return a page from the leaderboard around a given :id' do
        post '/api/v1/leaderboard/update', :id => 'david', :score => 10000
        get '/api/v1/leaderboard/around_me', :id => 'david'
        JSON.parse(last_response.body).tap do |api_response|
          api_response['status'].should == 'ok'
          api_response['data']['total_pages'].should == 1
          api_response['data']['current_page'].should == 1
        end
      end
    end
  end
end