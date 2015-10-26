class ScopeExample < ActiveRecord::Base
  #Scopes
    scope :submitted, -> { where(submitted: true) }
    scope :underutilized, -> { where('total_hours < 40') }
    scope :delinquent, -> { where('timesheets_updated_at < ?', 1.week.ago) }

  #same as ScopeExample.delinquent
    def self.delinquent
      where('timesheets_updated_at < ?', 1.week.ago)
    end

  #Scope Parameters
    scope :newer_than, ->(date) { where('start_date > ?', date) }

  #scope with multiple parameters
  def self.post_created_within(start_DT,end_DT)
    where('post_created_time >= ? AND post_created_time <= ?', start_DT.to_sql_date_time,end_DT.to_sql_date_time)
  end

  #scope Chaining
    scope :submitted, -> { where(submitted: true) }
    scope :underutilized, -> { submitted.where('total_hours < 40') }

  #scope and Join (Not Good to Know about the other table's column)
    #
    # User.tardy.to_sql
    # => "SELECT "users".* FROM "users"
    #    INNER JOIN "timesheets" ON "timesheets"."user_id" = "users"."id"
    #    WHERE (timesheets.submitted_at <= '2013-04-13 18:16:15.203293')
    #    GROUP BY users.id"  # query formatted nicely for the book
    #
    # In User class
    scope :tardy, -> {
      joins(:timesheets).
      where("timesheets.submitted_at <= ?", 7.days.ago).
      group("users.id")
    }

  #scope Combination
    # combine the other class's scope into the scope, such that it will not violate LoD
    # in User class
    scope :late, -> { where("timesheet.submitted_at <= ?", 7.days.ago) }
    # in TimeSheet
    scope :tardy, -> {
      joins(:timesheets).group("users.id").merge(Timesheet.late)
    }

  #default scope
    default_scope { where(status: "open") }
    #NOTICE that default_scope also apply to creating model
      # >> Timesheet.new
      # => #<Timesheet id: nil, status: "open">
      # >> Timesheet.create
      # => #<Timesheet id: 1, status: "open">

      # Override this property by
      # >> Timesheet.where(status: "new").new
      # => #<Timesheet id: nil, status: "new">
      # >> Timesheet.where(status: "new").create
      # => #<Timesheet id: 1, status: "new">

  # applying scope in block
    # >> Timesheet.order("submitted_at DESC").scoping do
    # >>   Timesheet.first
    # >> end

  # Unscope default scope
    # >> Timesheet.unscoped.order("submitted_at DESC").to_a
    # => [#<Timesheet id: 2, status: "submitted">]
end
