require 'test_helper'
require 'generators/rails/applist_controller/applist_controller_generator'

class Rails::ApplistControllerGeneratorTest < Rails::Generators::TestCase
  tests Rails::ApplistControllerGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
