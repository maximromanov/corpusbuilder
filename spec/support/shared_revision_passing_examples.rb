RSpec.shared_examples "revision accepting route" do
  context "when revision doesn't exist" do
    it "returns status 422 with proper message when given bad branch name" do
      bad_branch_request

      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)).to eq({ 'error' => 'Branch doesn\'t exist' })
    end

    it "returns status 422 with proper message when given bad revision id" do
      bad_revision_request

      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)).to eq({ 'error' => 'Revision doesn\'t exist' })
    end
  end

  context "when given existing branch name" do
    it "responds with HTTP 200 or 201" do
      good_branch_request

      expect(response.status).to eq(success_status)
    end
  end

  context "when given existing revision id" do
    it "responds with HTTP 200 or 201" do
      good_revision_request

      #byebug if response.status != success_status
    #  byebug if response.status == 500

      expect(response.status).to eq(success_status)
    end
  end
end
