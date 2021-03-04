class GithubService
  def repo_name
    data = get_url("https://api.github.com/repos/Trevorsuter/little-esty-shop")
  end

  def contributors
    data = get_url("https://api.github.com/repos/Trevorsuter/little-esty-shop/contributors")
  end

  def get_url(url)
    response = Faraday.get(url)
    json = JSON.parse(response.body, symbolize_names: true)
  end
end