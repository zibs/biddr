class PublishingsController < ApplicationController
  before_action :authenticate_user

    def create
      auction = current_user.auctions.find(params[:auction_id])
      service = Auctions::PublishAuction.new(auction: auction)
      # if campaign.publish!
      #   DetermineCampaignStateJob.set(wait_until: campaign.end_date).perform_later(campaign)
      #   redirect_to campaign, flash: { success: "Published!" }
      # else
      #   redirect_to campaign, flash: { danger: "Already published!"}
      # end
      # or
      if service.call
        redirect_to auction, flash: { success: "Published!" }
      else
        redirect_to auction, flash: { danger: "Already published!"}
      end
    end

end
