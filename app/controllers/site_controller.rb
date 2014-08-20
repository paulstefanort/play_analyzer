require 'open-uri'
require 'analyzer'

class SiteController < ApplicationController
  before_filter :load_plays

  def index
  end

  def play
    @play = Play.list.select { |play| play[:slug] == params[:slug] }.first
    file_name = @play[:file]
    file_path = File.expand_path("../../../data", __FILE__)
    @file = open("#{file_path}/#{file_name}")
    analyzer = Analyzer.new(file: @file)
    @speakers = analyzer.analyze_speakers
  end

  private
  def load_plays
    @plays = Play.list
  end
end
