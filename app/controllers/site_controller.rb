require 'open-uri'
require 'analyzer'

class SiteController < ApplicationController
  def index
    @plays = Play.list
  end

  def play
    slug = params[:slug]
    @play = Play.list.select { |play| play[:slug] == slug }.first
    file_name = @play[:file]
    file_path = File.expand_path("../../../data", __FILE__)
    @file = open("#{file_path}/#{file_name}")
    analyzer = Analyzer.new(file: @file)
    @speakers = analyzer.analyze_speakers
  end
end
