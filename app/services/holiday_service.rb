class HolidayService
  def holiday_names
    data = get_url('https://date.nager.at/Api/v2/NextPublicHolidays/US')
  end

  def get_url(url)
    response = Faraday.get(url)
    JSON.parse(response.body)[0..2]
  end
end
