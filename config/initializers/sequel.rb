# set db timezone
Sequel.tap do |_s|
  _s.application_timezone = :local
  _s.database_timezone = :utc
  _s.typecast_timezone = :utc
end