#ref
# => http://www.elabs.se/blog/36-working-with-time-zones-in-ruby-on-rails

#look up all the timezone
  rake time:zones:all
#look up local system timezone
  rake time:zones:local

#Cheat Sheet

#DOs
  2.hours.ago # => Fri, 02 Mar 2012 20:04:47 JST +09:00
  1.day.from_now # => Fri, 03 Mar 2012 22:04:47 JST +09:00
  Date.today.in_time_zone # => Fri, 02 Mar 2012 22:04:47 JST +09:00
  Date.current # => Fri, 02 Mar
  Time.zone.parse("2012-03-02 16:05:37") # => Fri, 02 Mar 2012 16:05:37 JST +09:00
  Time.zone.now # => Fri, 02 Mar 2012 22:04:47 JST +09:00
  Time.current # Same thing but shorter. (Thank you Lukas Sarnacki pointing this out.)
  Time.zone.today # If you really can't have a Time or DateTime for some reason
  Time.current.utc.iso8601 # When supliyng an API (you can actually skip .zone here, but I find it better to always use it, than miss it when it's needed)
  Time.strptime(time_string, "%Y-%m-%dT%H:%M:%S%z").in_time_zone # If you can't use time.zone.parse
#DON'Ts
  Time.now # => Returns system time and ignores your configured time zone.
  Time.parse("2012-03-02 16:05:37") # => Will assume time string given is in the system's time zone.
  Time.strptime(time_string, "%Y-%m-%dT%H:%M:%S%z") # Same problem as with Time#parse.
  Date.today # This could be yesterday or tomorrow depending on the machine's time zone.
  Date.today.to_time # => # Still not the configured time zone.

#infer the timezone of user

  #There are two ways to do this.
    #Indeed, you can use javascript to fetch their current time/timezone.
    #There is the possibility that the user's computer time is not set correctly,
    #in which case the time zone you display will not be correct.
    #Because you are using Rails, a recommended way is to get javascript already bundled as a gem,
    #like detect_timezone_rails. This makes it easy to install (because it is all bundled automatically in the asset pipeline.

    #You can use the IP address to infer their country and time zone.
    #The danger in this case is that a user may be using a proxy.
    #Also, while the IP address generally has city-level resolution,
    #it may be more or less accurate, which may in rare cases give the wrong time zone.
    #Using the IP address, you can get their approximate city and latitude/longitude.
    #There are many gems that can do this on Ruby Toolbox,
    #eg. geocoder. With the latitude/longitude, you can get the time zone using a gem like timezone.

    #You can also use one of the above, and allow the user to manually change their time zone on your website (either storing this setting in a database if registered, or as a cookie on their browser). This is useful in case you got the timezone wrong.

#Word Explanation
  #UTC, coordinated universal time
     #the standard of time used for timezone offsetting
     #used to store in database
  #ISO8601
    #the datetime format with timezone info
      #1994-11-05T08:15:30-05:00 corresponds to November 5, 1994, 8:15:30 am, US Eastern Standard Time.
      #1994-11-05T13:15:30Z corresponds to the same instant. (UTC time)

#Web API Time
  #When providing the time, use UTC which is timezone independent
    Time.current.utc.iso8601 #=> "2012-03-16T14:55:33Z"
  #When consumeing the time, use ISO8601, e.g.
    Time.strptime(time_string, "%Y-%m-%dT%H:%M:%S%z").in_time_zone


