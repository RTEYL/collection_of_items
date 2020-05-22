require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
set :method_override, true

use ItemsController
use CollectionsController
use UsersController
run ApplicationController