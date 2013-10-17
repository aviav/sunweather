require_relative "../lib/sun"

describe Sunweather::Sun, "after initializing with a string" do
  let(:geo) { Sunweather::Geo.new }
  let(:sun) { Sunweather::Sun.new(geo.lat, geo.lng) }

  it "contains the required data from Wunderground and Earthtools" do
    expect(sun.data_sunrise_sunset).not_to be_nil
    expect(Integer(sun.data_sunrise_sunset["sun_phase"][0]["sunrise"][0]["hour"][0])).to be_within(12).of(12)
    expect(Integer(sun.data_sunrise_sunset["sun_phase"][0]["sunrise"][0]["minute"][0])).to be_within(30).of(30)
    expect(Integer(sun.data_sunrise_sunset["sun_phase"][0]["sunset"][0]["hour"][0])).to be_within(12).of(12)
    expect(Integer(sun.data_sunrise_sunset["sun_phase"][0]["sunset"][0]["minute"][0])).to be_within(30).of(30)
    expect(sun.sunrise.min).to be_within(30).of(30)
    expect(sun.sunrise.hour).to be_within(12).of(12)
    expect(sun.sunset.min).to be_within(30).of(30)
    expect(sun.sunset.hour).to be_within(12).of(12)
    expect(sun.data_twilight).not_to be_nil
    expect(DateTime.parse(sun.data_twilight["morning"][0]["twilight"][0]["civil"][0]).sec).to be_within(30).of(30)
    expect(DateTime.parse(sun.data_twilight["morning"][0]["twilight"][0]["civil"][0]).min).to be_within(30).of(30)
    expect(DateTime.parse(sun.data_twilight["morning"][0]["twilight"][0]["civil"][0]).hour).to be_within(30).of(30)
    expect(DateTime.parse(sun.data_twilight["evening"][0]["twilight"][0]["civil"][0]).hour).to be_within(30).of(30)
    expect(DateTime.parse(sun.data_twilight["morning"][0]["sunrise"][0]).hour).to be_within(30).of(30)
    expect(DateTime.parse(sun.data_twilight["evening"][0]["sunset"][0]).hour).to be_within(30).of(30)
    expect(sun.sunrise_earthtools.sec).to be_within(30).of(30)
    expect(sun.sunrise_earthtools.min).to be_within(30).of(30)
    expect(sun.sunrise_earthtools.hour).to be_within(12).of(12)
    expect(sun.sunset_earthtools.sec).to be_within(30).of(30)
    expect(sun.sunset_earthtools.min).to be_within(30).of(30)
    expect(sun.sunset_earthtools.hour).to be_within(12).of(12)
    expect(sun.start_of_dawn_earthtools.sec).to be_within(30).of(30)
    expect(sun.start_of_dawn_earthtools.min).to be_within(30).of(30)
    expect(sun.start_of_dawn_earthtools.hour).to be_within(12).of(12)
    expect(sun.end_of_dusk_earthtools.sec).to be_within(30).of(30)
    expect(sun.end_of_dusk_earthtools.min).to be_within(30).of(30)
    expect(sun.end_of_dusk_earthtools.hour).to be_within(12).of(12)
    expect(sun.start_of_dawn.sec).to be_within(30).of(30)
    expect(sun.start_of_dawn.min).to be_within(30).of(30)
    expect(sun.start_of_dawn.hour).to be_within(12).of(12)
    expect(sun.end_of_dusk.sec).to be_within(30).of(30)
    expect(sun.end_of_dusk.min).to be_within(30).of(30)
    expect(sun.end_of_dusk.hour).to be_within(12).of(12)
    expect(sun.dawn_length.sec).to be_within(30).of(30)
    expect(sun.dawn_length.min).to be_within(30).of(30)
    expect(sun.dawn_length.hour).to be_within(12).of(12)
    expect(sun.dusk_length.sec).to be_within(30).of(30)
    expect(sun.dusk_length.min).to be_within(30).of(30)
    expect(sun.dusk_length.hour).to be_within(12).of(12)
  end
end