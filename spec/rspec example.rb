describe GlobalScopeProfile do
  describe ".post_sources_settings" do
    #before each test case, the default is before(:each)
    before do
      PostSource.create! post_source_id: 1, name: 'ps'
      GlobalScopeProfile.create! id:1, post_sources_settings_lists: 1
    end
    #the subject is used to generalize the duplicated element
    subject(:g) { GlobalScopeProfile.where("id = 1").first }

    it 'get post_sources_names' do
        expect(g.post_sources_name_list[0]).to eq('ps')
    end

    it 'get post_sources_settings_lists' do
        expect(g.post_sources_settings_lists[0]).to eq(1)
    end
  end

  describe ".end_to" do
    before do
      #the variable can be changed by using the value returned by let()
      GlobalScopeProfile.create! end_to: "2015-01-01", end_to_now: end_to_now_options
    end
    subject(:g) { GlobalScopeProfile.first }

    context "when end_to_now_options is true" do
      let(:end_to_now_options) { 1 }

      it 'return a day ago from now ' do
        expect(g.end_to.to_date).to eq(DateTime.now.to_date)
      end
    end

    context "when end_to_now_options is false" do
      let(:end_to_now_options) { 0 }

      it 'return a day ago from now ' do
        expect(g.end_to).to eq("2015-01-01")
      end
    end
  end

  describe ".begin_from" do
    before do
      GlobalScopeProfile.create! begin_from_ago: begin_from_options , begin_from: "2015-01-01", end_to_now: end_to_now_options
    end
    subject(:g) { GlobalScopeProfile.first }

    context "when end_to_now_options is true" do
      let(:end_to_now_options) { 1 }

      context "when begin from ago is day" do
        let(:begin_from_options) { "day" }

        it 'return a day ago from now ' do
            expect(g.begin_from.to_date).to eq((DateTime.now - 1.day).to_date)
        end
      end
      context "when begin from ago is week" do
        let(:begin_from_options) { "week" }

        it 'return a week ago from now ' do
            expect(g.begin_from.to_date).to eq((DateTime.now - 1.week).to_date)
        end
      end
      context "when begin from ago is month" do
        let(:begin_from_options) { "month" }

        it 'return a week ago from now ' do
            expect(g.begin_from.to_date).to eq((DateTime.now - 1.month).to_date)
        end
      end
      context "when begin from ago is not set" do
        let(:begin_from_options) { nil }

        it 'return a week ago from now ' do
            expect(g.begin_from).to eq("2015-01-01")
        end
      end
    end
  end
end
