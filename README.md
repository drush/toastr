= Toastr

Acts like standard cache, but instead of blocking and recalculating, it serves stale data and kicks off a job to refresh it in the background.

== INSTALLATION

1. Install the gem

```ruby
gem 'toastr', github: 'drush/toastr'
```

2. Run the generator

```console
rails generate toastr:install
```

3. Migrate your database

```console
rake db:migrate
```

== USAGE

1. Define an instance method on an ActiveRecord.
2. After defining the method, declare

```ruby
has_toast :method_name
```

3. Three options for expiring the cached data are available, shown below

```ruby
class Oat < ActiveRecord::Base
  has_many :related_records

  def breakfast
    sleep 2
    {oat: :meal}
  end
  # by default only updates if this Oat instance is updated after the toast was calculated
  has_toast :breakfast

  def daily_report
    sleep 2
    {daily: :report}
  end
  # update if toast is older than 1 day
  has_toast :daily_report, expire_in: 1.day

  def arbitrary_expiration
    sleep 2
    {arbitrary: :expiration}
  end
  # update on arbitrary block. example updates toast if any of its :related_records
  # have been updated since the toast was last updated
  has_toast :special, expire_if: -> (toast) { toast.parent.related_records.pluck(:updated_at).max > toast.updated_at }

end
```

```console
2.1.5 :001 > @oat = Oat.create
=> #<Oat id: 1, created_at: "2015-06-09 23:13:41", updated_at: "2015-06-09 23:13:41"> 
2.1.5 :002 > @oat.breakfast
=> {:error=>"Data not yet available"}
2.1.5 :003 > @oat.breakfast # after waiting enough time for the toast to calculate
=> {"oat"=>"meal", "toastr"=>{"elapsed"=>2.010508, "cached_at"=>"2015-06-09T16:14:25.701-07:00"}}
```

== TODO
* Extended test coverage
* How to resolve conflicts between job_state and cache_state when errors occur

== CHANGELOG
* Installation generator
* Basic test coverage
* Adopt ActiveJob support instead of DJ

This project rocks and uses MIT-LICENSE.
