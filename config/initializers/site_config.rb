if Rails.env.development?
	MEDIA_URL_BASE = 'http://portal3.signedout.local'
elsif Rails.env.test?
	MEDIA_URL_BASE = 'http://portal3.signedout.local'
elsif Rails.env.production?
	MEDIA_URL_BASE = 'http://portal.adamfontana.ca'
elsif Rails.env.staging?
  MEDIA_URL_BASE = 'http://screenfluence.staig.me'
end

DAYS_OF_THE_WEEK = [
  "Sun","Mon","Tues","Wed","Thurs","Fri", "Sat"
]
