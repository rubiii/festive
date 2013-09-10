require 'test_helper'

class EventTest < ActiveSupport::TestCase

  setup do
    @event = Event.new
  end

  test 'validates presence of #description' do
    @event.valid?
    assert @event.errors['description'].present?
  end

  test 'validates presence of #area' do
    @event.valid?
    assert @event.errors['area'].present?
  end

  test 'validates presence of #starts_at' do
    @event.valid?
    assert @event.errors['starts_at'].present?
  end

  test 'validates presence of #ends_at' do
    @event.valid?
    assert @event.errors['ends_at'].present?
  end

end
