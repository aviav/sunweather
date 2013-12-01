require_relative "../lib/geo"
require_relative "../lib/data"

describe Sunweather::Data, "after initializing with geocoordinates from default Geo object" do
  let(:geo) { Sunweather::Geo.new }
  let(:data) { Sunweather::Data.new(geo.lat, geo.lng) }

  it "contains the required data from World Weather Online, Wunderground and Earthtools" do
    expect(data.data_astro_conditions).not_to be_nil
    expect(data.data_astro_conditions["current_observation"][0]["observation_epoch"][0].to_i).to be_within(7*86400).of(Time.now.to_i)
    expect(Float(data.data_astro_conditions["current_observation"][0]["temp_c"][0])).to be_within(100).of(0)
    expect(Float(data.data_astro_conditions["current_observation"][0]["feelslike_c"][0])).to be_within(100).of(0)
    expect(data.data_astro_conditions["current_observation"][0]["weather"][0]).to_not be_empty
    expect(data.data_astro_conditions["current_observation"][0]["wind_string"][0]).to_not be_empty
    expect(data.data_astro_conditions["current_observation"][0]["wind_dir"][0]).to_not be_empty
    expect(data.data_forecast).not_to be_nil
    expect(data.data_forecast["weather"][0]["tempMinC"][0].to_i).to be_within(100).of(0)
    expect(data.data_forecast["weather"][0]["tempMaxC"][0].to_i).to be_within(100).of(0)
    expect(data.data_forecast["weather"][0]["weatherDesc"][0]).to_not be_empty
    expect(data.data_forecast["weather"][0]["windspeedKmph"][0].to_i).to be_within(100).of(100)
    expect(data.data_forecast["weather"][0]["winddir16Point"][0]).to_not be_empty
    expect(data.data_forecast["weather"][4]["tempMinC"][0].to_i).to be_within(100).of(0)
    expect(data.data_forecast["weather"][4]["tempMaxC"][0].to_i).to be_within(100).of(0)
    expect(data.data_forecast["weather"][4]["weatherDesc"][0]).to_not be_empty
    expect(data.data_forecast["weather"][4]["windspeedKmph"][0].to_i).to be_within(100).of(100)
    expect(data.data_forecast["weather"][4]["winddir16Point"][0]).to_not be_empty
    expect(data.temperature).to be_within(100).of(0)
    expect(data.feels_like).to be_within(100).of(0)
    expect(data.observation_time.min).to be_within(30).of(30)
    expect(data.conditions).to_not be_empty
    expect(data.wind_speed).to_not be_empty
    expect(data.data_astro_conditions).not_to be_nil
    expect(data.data_astro_conditions["sun_phase"][0]["sunrise"][0]["hour"][0].to_i).to be_within(12).of(12)
    expect(data.data_astro_conditions["sun_phase"][0]["sunrise"][0]["minute"][0].to_i).to be_within(30).of(30)
    expect(data.data_astro_conditions["sun_phase"][0]["sunset"][0]["hour"][0].to_i).to be_within(12).of(12)
    expect(data.data_astro_conditions["sun_phase"][0]["sunset"][0]["minute"][0].to_i).to be_within(30).of(30)
    expect(data.sunrise.min).to be_within(30).of(30)
    expect(data.sunrise.hour).to be_within(12).of(12)
    expect(data.sunset.min).to be_within(30).of(30)
    expect(data.sunset.hour).to be_within(12).of(12)
    expect(data.data_twilight).not_to be_nil
    expect(DateTime.parse(data.data_twilight["morning"][0]["twilight"][0]["civil"][0]).sec).to be_within(30).of(30)
    expect(DateTime.parse(data.data_twilight["morning"][0]["twilight"][0]["civil"][0]).min).to be_within(30).of(30)
    expect(DateTime.parse(data.data_twilight["morning"][0]["twilight"][0]["civil"][0]).hour).to be_within(30).of(30)
    expect(DateTime.parse(data.data_twilight["evening"][0]["twilight"][0]["civil"][0]).hour).to be_within(30).of(30)
    expect(DateTime.parse(data.data_twilight["morning"][0]["sunrise"][0]).hour).to be_within(30).of(30)
    expect(DateTime.parse(data.data_twilight["evening"][0]["sunset"][0]).hour).to be_within(30).of(30)
    expect(data.sunrise_earthtools.sec).to be_within(30).of(30)
    expect(data.sunrise_earthtools.min).to be_within(30).of(30)
    expect(data.sunrise_earthtools.hour).to be_within(12).of(12)
    expect(data.sunset_earthtools.sec).to be_within(30).of(30)
    expect(data.sunset_earthtools.min).to be_within(30).of(30)
    expect(data.sunset_earthtools.hour).to be_within(12).of(12)
    expect(data.start_of_dawn_earthtools.sec).to be_within(30).of(30)
    expect(data.start_of_dawn_earthtools.min).to be_within(30).of(30)
    expect(data.start_of_dawn_earthtools.hour).to be_within(12).of(12)
    expect(data.end_of_dusk_earthtools.sec).to be_within(30).of(30)
    expect(data.end_of_dusk_earthtools.min).to be_within(30).of(30)
    expect(data.end_of_dusk_earthtools.hour).to be_within(12).of(12)
    expect(data.start_of_dawn.sec).to be_within(30).of(30)
    expect(data.start_of_dawn.min).to be_within(30).of(30)
    expect(data.start_of_dawn.hour).to be_within(12).of(12)
    expect(data.end_of_dusk.sec).to be_within(30).of(30)
    expect(data.end_of_dusk.min).to be_within(30).of(30)
    expect(data.end_of_dusk.hour).to be_within(12).of(12)
    expect(data.dawn_length.sec).to be_within(30).of(30)
    expect(data.dawn_length.min).to be_within(30).of(30)
    expect(data.dawn_length.hour).to be_within(12).of(12)
    expect(data.dusk_length.sec).to be_within(30).of(30)
    expect(data.dusk_length.min).to be_within(30).of(30)
    expect(data.dusk_length.hour).to be_within(12).of(12)
  end
end