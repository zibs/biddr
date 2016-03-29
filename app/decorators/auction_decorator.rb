class AuctionDecorator < Draper::Decorator
  delegate_all

  def display_aasm_status
      bootstrap_classes = {"published" => "label-info",
                          "reserve_met" => "label-success",
                          "cancelled" => "label-warning",
                          "draft" => "label-primary"
                          }

      h.content_tag :div, class: "label #{bootstrap_classes[object.aasm_state]}" do
          object.aasm_state
      end
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
