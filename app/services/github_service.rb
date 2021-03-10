class GithubService
  def repo_name
    data = get_url("https://api.github.com/repos/Trevorsuter/little-esty-shop")
  end

  def contributors
    data = get_url("https://api.github.com/repos/Trevorsuter/little-esty-shop/contributors")
  end

  def pull_request
    get_url("https://api.github.com/repos/Trevorsuter/little-esty-shop/pulls?state=closed")
  end

  def create_contributors
    contributors.map do |data|
      Contributor.new(data)
    end
  end

  def get_url(url)
    response = Faraday.get(url) do |req|
      req.headers['Authorization'] = "token #{ENV['GITHUB_TOKEN']}"
    end
    data = response.body
    json = JSON.parse(data, symbolize_names: true)
  end
end
