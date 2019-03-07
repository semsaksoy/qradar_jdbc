require 'openssl'
require 'net/http'
require "uri"
require 'date'
require "json"

##config
@sec = "cc947788-xxxxxxxx"
@host="https://127.0.0.1"
##config


def get_logsource

  uri = URI("#{@host}/api/config/event_sources/log_source_management/log_sources")
  req = Net::HTTP::Get.new(uri)
  req['SEC'] = @sec
  req['Version']= "9.1"
  req['Accept'] = "application/json"
  req["Content-Type"]= "application/json"

  res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true, :verify_mode => OpenSSL::SSL::VERIFY_NONE) { |http|
    http.request(req)
  }
  data=JSON.parse(res.body)

  data= data.select { |s| s["protocol_type_id"]==8 && s["internal"]!=true && s["enabled"]==true && ((DateTime.now- DateTime.strptime(s["last_event_time"].to_s, '%Q'))*24).to_i>=2 }
  cikti= data.map { |s| s["id"] }

  get_logsource=cikti
end

def e_d liste

#kapat
  liste.each do |ls|

    uri = URI("#{@host}/api/config/event_sources/log_source_management/log_sources/#{ls}")
    req = Net::HTTP::Post.new(uri)
    req['SEC'] = @sec
    req['Version']= "9.1"
    req['Accept'] = "application/json"
    req["Content-Type"]= "application/json"
    req.body={"enabled" => false}.to_json
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true, :verify_mode => OpenSSL::SSL::VERIFY_NONE) { |http|
      r= http.request(req)
    }
    data=JSON.parse(res.body)
    p "#{data["name"]} = #{data["status"]}"
  end

#ac
  liste.each do |ls|

    uri = URI("#{@host}/api/config/event_sources/log_source_management/log_sources/#{ls}")
    req = Net::HTTP::Post.new(uri)
    req['SEC'] = @sec
    req['Version']= "9.1"
    req['Accept'] = "application/json"
    req["Content-Type"]= "application/json"
    req.body={"enabled" => true}.to_json
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true, :verify_mode => OpenSSL::SSL::VERIFY_NONE) { |http|
      http.request(req)
    }
    data=JSON.parse(res.body)
    p "#{data["name"]} = #{data["status"]}"
  end

end

liste= get_logsource
e_d liste

#/bin/ruby /root/AutoDE/main.rb
