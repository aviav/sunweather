require_relative "../lib/geo"

describe Sunweather::Geo, "after initializing with a string" do
	let (:geo) { Sunweather::Geo.new("test") }

  it "contains data which is useful" do
    expect(geo.data).not_to be_nil
    expect(geo.data[0].data["geometry"]["location"]["lat"]).to be_within(90).of(0)
    expect(geo.data[0].data["geometry"]["location"]["lng"]).to be_within(180).of(0)
    expect(geo.lat).to be_within(90).of(0)
    expect(geo.lng).to be_within(180).of(0)
  end
end

describe Sunweather::Geo, "after initializing without a string" do
	let (:geo) { Sunweather::Geo.new }

  it "contains data which is useful" do
    expect(geo.data).not_to be_nil
    expect(geo.data[0].data["geometry"]["location"]["lat"]).to be_within(90).of(0)
    expect(geo.data[0].data["geometry"]["location"]["lng"]).to be_within(180).of(0)
    expect(geo.lat).to eq(51.713741)
    expect(geo.lng).to eq(8.770812)
  end
end