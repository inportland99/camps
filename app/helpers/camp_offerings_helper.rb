module CampOfferingsHelper
  def open_spots(co)
    spots = co.open_spots.to_i
    case spots
    when 1
      "#{co.open_spots} spot"
    when 2..4
      "#{co.open_spots} spots"
    else
      ""
    end
  end
end
