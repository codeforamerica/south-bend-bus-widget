module ApplicationHelper

  def self.get_stringified_now
    Time.now.hour.to_s + ":" + Time.now.min.to_s + ":" + Time.now.sec.to_s
  end

  def self.get_stringified_soon
    @soon_time = Time.now + 90*60
    @soon_time.hour.to_s + ":" + @soon_time.min.to_s + ":" + @soon_time.sec.to_s
  end

end

