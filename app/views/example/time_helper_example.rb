#select datetime
  my_date_time = Time.now + 4.days
  # Generates a datetime select that defaults to the datetime in my_date_time (four days after today).
  select_datetime(my_date_time)

  # Generates a datetime select that defaults to today (no specified datetime)
  select_datetime()

  # Generates a datetime select that defaults to the datetime in my_date_time (four days after today)
  # with the fields ordered year, month, day rather than month, day, year.
  select_datetime(my_date_time, order: [:year, :month, :day])

  # Generates a datetime select that defaults to the datetime in my_date_time (four days after today)
  # with a '/' between each date field.
  select_datetime(my_date_time, date_separator: '/')

  # Generates a datetime select that defaults to the datetime in my_date_time (four days after today)
  # with a date fields separated by '/', time fields separated by '' and the date and time fields
  # separated by a comma (',').
  select_datetime(my_date_time, date_separator: '/', time_separator: '', datetime_separator: ',')

  # Generates a datetime select that discards the type of the field and defaults to the datetime in
  # my_date_time (four days after today)
  select_datetime(my_date_time, discard_type: true)

  # Generate a datetime field with hours in the AM/PM format
  select_datetime(my_date_time, ampm: true)

  # Generates a datetime select that defaults to the datetime in my_date_time (four days after today)
  # prefixed with 'payday' rather than 'date'
  select_datetime(my_date_time, prefix: 'payday')

  # Generates a datetime select with a custom prompt. Use <tt>prompt: true</tt> for generic prompts.
  select_datetime(my_date_time, prompt: {day: 'Choose day', month: 'Choose month', year: 'Choose year'})
  select_datetime(my_date_time, prompt: {hour: true}) # generic prompt for hours
  select_datetime(my_date_time, prompt: true) # generic prompts for all

#select date
  my_date = Time.now + 6.days
  # Generates a date select that defaults to the date in my_date (six days after today).
  select_date(my_date)

  # Generates a date select that defaults to today (no specified date).
  select_date()

  # Generates a date select that defaults to the date in my_date (six days after today)
  # with the fields ordered year, month, day rather than month, day, year.
  select_date(my_date, order: [:year, :month, :day])

  # Generates a date select that discards the type of the field and defaults to the date in
  # my_date (six days after today).
  select_date(my_date, discard_type: true)

  # Generates a date select that defaults to the date in my_date,
  # which has fields separated by '/'.
  select_date(my_date, date_separator: '/')

  # Generates a date select that defaults to the datetime in my_date (six days after today)
  # prefixed with 'payday' rather than 'date'.
  select_date(my_date, prefix: 'payday')

  # Generates a date select with a custom prompt. Use <tt>prompt: true</tt> for generic prompts.
  select_date(my_date, prompt: {day: 'Choose day', month: 'Choose month', year: 'Choose year'})
  select_date(my_date, prompt: {hour: true}) # generic prompt for hours
  select_date(my_date, prompt: true) # generic prompts for all
