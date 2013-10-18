require_relative "../lib/geo"
require_relative "../lib/weather"

describe Sunweather::Weather, "after initializing with geocoordinates from default Geo object" do
  let(:geo) { Sunweather::Geo.new }
  let(:weather) { Sunweather::Weather.new(geo.lat, geo.lng) }

  it "contains the required data from World Weather Online" do
    expect(weather.data_current).not_to be_nil
    expect(Integer(weather.data_current["current_observation"][0]["observation_epoch"][0])).to be_within(7*86400).of(Time.now.to_i)
    expect(Float(weather.data_current["current_observation"][0]["temp_c"][0])).to be_within(100).of(0)
    expect(Float(weather.data_current["current_observation"][0]["feelslike_c"][0])).to be_within(100).of(0)
    expect(weather.data_current["current_observation"][0]["weather"][0]).to_not be_empty
    expect(weather.data_current["current_observation"][0]["wind_string"][0]).to_not be_empty
    expect(weather.data_current["current_observation"][0]["wind_dir"][0]).to_not be_empty
    expect(weather.data_forecast).not_to be_nil
    expect(Integer(weather.data_forecast["weather"][0]["tempMinC"][0])).to be_within(100).of(0)
    expect(Integer(weather.data_forecast["weather"][0]["tempMaxC"][0])).to be_within(100).of(0)
    expect(weather.data_forecast["weather"][0]["weatherDesc"][0]).to_not be_empty
    expect(Integer(weather.data_forecast["weather"][0]["windspeedKmph"][0])).to be_within(100).of(100)
    expect(weather.data_forecast["weather"][0]["winddir16Point"][0]).to_not be_empty
    expect(Integer(weather.data_forecast["weather"][4]["tempMinC"][0])).to be_within(100).of(0)
    expect(Integer(weather.data_forecast["weather"][4]["tempMaxC"][0])).to be_within(100).of(0)
    expect(weather.data_forecast["weather"][4]["weatherDesc"][0]).to_not be_empty
    expect(Integer(weather.data_forecast["weather"][4]["windspeedKmph"][0])).to be_within(100).of(100)
    expect(weather.data_forecast["weather"][4]["winddir16Point"][0]).to_not be_empty
    expect(weather.temperature).to be_within(100).of(0)
    expect(weather.feels_like).to be_within(100).of(0)
    expect(weather.observation_time.min).to be_within(30).of(30)
    expect(weather.conditions).to_not be_empty
    expect(weather.wind_speed).to_not be_empty
	end
end