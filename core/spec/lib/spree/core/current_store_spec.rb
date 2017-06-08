require 'spec_helper'

describe Spree::Core::CurrentStore do
  describe "#store" do
    subject { Spree::Deprecation.silence { Spree::Core::CurrentStore.new(request).store } }

    context "with a default" do
      let(:request) { double(headers: {}, env: {}) }
      let!(:store_1) { create :store, default: true }

      it "returns the default store" do
        expect(subject).to eq(store_1)
      end

      context "with a domain match" do
        let(:request) { double(headers: {}, env: { "SERVER_NAME" => url } ) }
        let(:url) { "server-name.org" }
        let!(:store_2) { create :store, default: false, url: url }

        it "returns the store with the matching domain" do
          expect(subject).to eq(store_2)
        end

        context "with headers" do
          let(:request) { double(headers: { "HTTP_SPREE_STORE" => headers_code }, env: {}) }
          let(:headers_code) { "HEADERS" }
          let!(:store_3) { create :store, code: headers_code, default: false }

          it "returns the store with the matching code" do
            expect(subject).to eq(store_3)
          end
        end
      end
    end

    it 'is deprecated' do
      expect(Spree::Deprecation).to(receive(:warn))
      Spree::Core::CurrentStore.new(double)
    end
  end
end
