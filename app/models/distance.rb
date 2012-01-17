class Distance
  attr_accessor :longitude1 , :latitude1 ,:longitude2 , :latitude2
  def initialize(longitude1, latitude1 ,longitude2 ,latitude2)
    @longitude1 = longitude1
    @latitude1 = latitude1
    @longitude2 = longitude2
    @latitude2 = latitude2
  end

  def difference_between_locations
    #begin
      theta = self.longitude1- self.longitude2
      distance_bet_videos = Math.sin(deg2rad(self.latitude1)) * Math.sin(deg2rad(self.latitude2)) + Math.cos(deg2rad(self.latitude1)) * Math.cos(deg2rad(self.latitude2)) * Math.cos(deg2rad(theta))
      distance_diff = Math.acos(distance_bet_videos) rescue Math.acos(distance_bet_videos.to_i)
      distance_diff = rad2deg(distance_diff)
      distance_diff = (distance_diff * 60 * 1.1515).abs
    #rescue
      #Cluster::RADIUS_DISTANCE + 1
    #end
  end

  def deg2rad(degrees)
    return (degrees.to_f / 180.0 * Math::PI)
  end

  def rad2deg(rad)
    return (rad * 180.0 / Math::PI)
  end
end
