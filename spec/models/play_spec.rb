require 'rails_helper'
require 'play'

describe Play do
  it 'should return a list of plays' do
    expect(Play.list).to be_a(Array)
  end
end
