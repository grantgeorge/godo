require 'spec_helper'

describe EventsController do
  render_views
  describe "index" do
    before do
      Event.create!(name: 'Skydiving with Friends')
      Event.create!(name: 'Exploring the world')
      Event.create!(name: 'Skydiving Meetup')
      Event.create!(name: 'Electro Concert')

      xhr :get, :index, format: :json, keywords: keywords
    end

    subject(:results) { JSON.parse(response.body) }

    def extract_name
      ->(object) { object["name"] }
    end

    context "when the search finds results" do
      let(:keywords) { 'Skydiving' }
      it 'should 200' do
        expect(response.status).to eq(200)
      end
      it 'should return two results' do
        expect(results.size).to eq(2)
      end
      it "should include 'Skydiving with Friends'" do
        expect(results.map(&extract_name)).to include('Skydiving with Friends')
      end
      it "should include 'Skydiving Meetup'" do
        expect(results.map(&extract_name)).to include('Skydiving Meetup')
      end
    end

    context "when the search doesn't find results" do
      let(:keywords) { 'foo' }
      it 'should return no results' do
        expect(results.size).to eq(0)
      end
    end

  end

  describe "show" do
    before do
      xhr :get, :show, format: :json, id: event_id
    end

    subject(:results) { JSON.parse(response.body) }

    context "when the event exists" do
      let(:event) {
        Event.create!(name: 'Skydiving w/ Friends',
          description: "Skydiving lez go!")
      }
      let(:event_id) { event.id }

      it { expect(response.status).to eq(200) }
      it { expect(results["id"]).to eq(event.id) }
      it { expect(results["name"]).to eq(event.name) }
      it { expect(results["description"]).to eq(event.description) }
    end

    context "when the event doens't exist" do
      let(:event_id) { -9999 }
      it { expect(response.status).to eq(404) }
    end
  end

  describe "create" do
    before do
      xhr :post, :create, format: :json, event: { name: "Exploring Jupiter",
        description: "A pretty good time!" }
    end
    it { expect(response.status).to eq(201) }
    it { expect(Event.last.name).to eq("Exploring Jupiter") }
    it { expect(Event.last.description).to eq("A pretty good time!")}
  end

  describe "update" do
    let(:event) {
      Event.create!(name: 'Skydiving w/ Friends',
        description: "Skydiving lez go!")
    }
    before do
      xhr :put, :update, format: :json, id: event.id, event: { name: "Teleporting",
        description: "Teleport to a different world"}

      event.reload
    end
    it { expect(response.status).to eq(204) }
    it { expect(event.name).to eq("Teleporting") }
    it { expect(event.description).to eq("Teleport to a different world") }
  end

  describe "destroy" do
    let(:event_id) {
      Event.create!(name: 'Skydiving w/ Friends',
        description: "Skydiving lez go!")
    }
    before do
      xhr :delete, :destroy, format: :json, id: event_id
    end
    it { expect(response.status).to eq(204) }
    it { expect(Event.find_by_id(event_id)).to be_nil }
  end

end
