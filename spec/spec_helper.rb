# typed: false
ENV['RACK_ENV'] = 'test'
require 'commands/order/add_guest'
require 'commands/order/place_order_guest'
require 'commands/order/place_order'
require 'coveralls'
require 'models/user'
require 'data_mapper'
require 'date'
require 'days'

Coveralls.wear!

class Helper
  def self.order(data)
    set_order_command = Commands::PlaceOrder.new
    set_order_command.prepare(data)
    set_order_command.run
  end

  def self.order_previous_monday(data)
    data[:date] = Days.monday - 8
    set_order_command = Commands::PlaceOrder.new
    set_order_command.prepare(data)
    set_order_command.run
  end

  def self.order_guest(data)
    from = data[:from] || "host id"
    place_order_guest = Commands::PlaceOrderGuest.new
    place_order_guest.prepare(
      user_id: from,
      user_message: "order -#{data[:name]}-: #{data[:meal]}",
      date: Days.monday
    )
    place_order_guest.run
  end

  def self.order_guest_previous_monday(data)
    from = data[:from] || "host id"
    place_order_guest = Commands::PlaceOrderGuest.new
    place_order_guest.prepare(
      user_id: from,
      user_message: "order -#{data[:name]}-: #{data[:meal]}",
      date: Days.monday - 8
    )
    place_order_guest.run
  end

  def self.add_guest(name)
    place_order_guest = Commands::AddGuest.new
    place_order_guest.prepare(
      user_message: "add guest: #{name}",
      user_id: "host id",
      date: Days.monday
    )
    place_order_guest.run
  end

  def self.add_guest_previous_monday(name)
    place_order_guest = Commands::AddGuest.new
    place_order_guest.prepare(
      user_message: "add guest: #{name}",
      user_id: "host id",
      date: Days.monday - 8
    )
    place_order_guest.run
  end
end

RSpec.configure do |config|
  config.filter_run_when_matching(focus: true)
  config.filter_gems_from_backtrace 'rack', 'rack-test', 'sinatra'
  config.order = :random

  # bundle exec rspec --tag fast
  config.define_derived_metadata(file_path: /spec\/unit/) do |meta|
    meta[:fast] = true
  end

  DataMapper.setup(:default, "sqlite::memory:")

  config.before(:each) do
    DataMapper.finalize.auto_migrate!

    user = User.new(
      user_name: "Fabien",
      slack_id: "FabienUserId",
      office: "london"
    )
    user.save

    user = User.new(
      user_name: "Will",
      slack_id: "WillUserId",
      office: "london"
    )
    user.save
  end
end
