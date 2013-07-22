## Configure the Geocoder services
Geocoder.configure(

  # geocoding service (see below for supported options):
  :lookup => :mapquest,

  # geocoding service request timeout, in seconds (default 3):
  :timeout => 5,

  # set default units to kilometers:
  :units => :km,

  # caching (see below for details):
  # :cache => Redis.new,

)
