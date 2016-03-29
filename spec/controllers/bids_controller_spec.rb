require 'rails_helper'

RSpec.describe BidsController, type: :controller do

  let(:auction){create(:auction)}
  let(:user){create(:user)}
  let(:bid){create(:bid, {auction: auction, user: user})}
  let(:other_bid){create(:bid)}

  describe "#create" do

    context "with unsigned in user" do
      it "redirects to the sign in page" do
        post :create, auction_id: auction.id, bid: attributes_for(:bid)
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with signed in user" do

      before { log_in(user) }

      context "with valid parameters" do
        def send_valid_request
          post :create, auction_id: auction.id, bid: attributes_for(:bid)
        end

        it "creates the record in the database associated with the campaign" do
          expect{send_valid_request}.to change{auction.bids.count}.by(1)
        end

        it "associates the pledge with the logged in user" do
          send_valid_request
          expect(Bid.last.user).to eq(user)
        end

        it "redirects to the campaign show page" do
          expect(send_valid_request).to redirect_to(auction_path(auction))
        end

        it "sets a flash notice" do
          send_valid_request
          expect(flash[:success]).to be
        end
      end

      context "with invalid parameters" do
        def send_invalid_request
          post :create, auction_id: auction.id, bid: attributes_for(:bid, {amount: nil})
        end

        it "creates the record in the database associated with the campaign" do

          expect{send_invalid_request}.to change{auction.bids.count}.by(0)
        end

        it "sets a flash alert message" do
          send_invalid_request
          expect(flash[:warning]).to be
        end

      end

    end
  end
end
