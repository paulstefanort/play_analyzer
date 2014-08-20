require 'nokogiri'

class Analyzer
  attr_accessor :file

  def initialize(options={})
    @file = Nokogiri::XML(options[:file])
  end

  def analyze_speeches
    speeches = []
    @file.xpath('//SPEECH').each do |speech|
      speeches << parse_speech(speech)
    end
    speeches
  end

  def parse_speech(speech)
    {
      speaker: speech.xpath('SPEAKER').first.text.capitalize,
      lines: speech.xpath('LINE').count
    }
  end

  def analyze_speakers
    speakers = Hash.new(0)
    analyze_speeches.each do |speech|
      speaker = speech[:speaker]
      speakers[speaker] += speech[:lines]
    end
    speakers = speakers.sort_by{ |name, lines| lines }.reverse
    speakers.map { |name, lines| {name: name, lines: lines} }
  end
end

