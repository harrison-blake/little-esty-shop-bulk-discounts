class ApplicationController < ActionController::Base
  before_action :api

  def api
    @service = GithubService.new
    binding.pry
    @repo = RepoName.new(@service.repo_name)

    # @contributors = @service.create_contributors
  end
end
