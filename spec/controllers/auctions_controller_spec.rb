require 'rails_helper'

RSpec.describe AuctionsController, :type => :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:auction) {FactoryGirl.create(:auction)}
  let(:other_auction) {FactoryGirl.create(:auction)}

  describe "#new" do
    before{ log_in(user) }
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "instantiates a new Auction object and set it to @auction" do
      get :new
      expect(assigns(:auction)).to be_a_new(Auction)
    end
  end

  describe "#create" do
    before{ log_in(user) }

    context "with valid attributes" do

      def valid_request
        post :create, auction: { title: "abcc", details: "esdadfg", reserve_price: 150, ends_on: "19/12/12" }
      end

      it "creates a record in the database" do
        expect{valid_request}.to change{Auction.count}.by(1)
      end

      it "redirects to the auction #show page" do
        valid_request
        expect(response).to redirect_to(auction_path(Auction.last))
      end

      it "sets a flash notice message" do
        valid_request
        expect(flash[:success]).to be
      end
    end

    context "with invalid attributes" do

      def invalid_request
        post :create, auction: { name: "", description: "", goal: 4 }
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "doesn't a record in the database" do
        expect{invalid_request}.to change{Auction.count}.by(0)

      end

      it "sets a flash alert message" do
        invalid_request
        expect(flash[:info]).to be
      end
    end
  end
end
