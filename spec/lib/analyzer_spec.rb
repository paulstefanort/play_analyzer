require 'rails_helper'
require 'analyzer'

describe Analyzer do
  it 'should load an XML file' do
    file_name = 'all_well.xml'
    file_path = File.expand_path('../../../data', __FILE__)
    analyzer = Analyzer.new(file: open("#{file_path}/#{file_name}"))
    expect(analyzer.file).to be_a(Nokogiri::XML::Document)
  end

  it 'should parse speech details' do
    speech = "<SPEECH><SPEAKER>MALCOLM</SPEAKER>\n
              <LINE>This is the sergeant</LINE>\n
              <LINE>Who like a good and hardy soldier fought</LINE>\n
              <LINE>'Gainst my captivity. Hail, brave friend!</LINE>\n
              <LINE>Say to the king the knowledge of the broil</LINE>\n
              <LINE>As thou didst leave it.</LINE></SPEECH>"

    analyzer = Analyzer.new(file: speech)
    parsed_speech = analyzer.parse_speech(Nokogiri::XML(speech).xpath('//SPEECH').first)
    expect(parsed_speech[:speaker]).to eq 'Malcolm'
    expect(parsed_speech[:lines]).to eq 5
  end

  it 'should parse a collection of speeches and speakers' do
    speeches_xml = "<ACT><SPEECH>
      <SPEAKER>DUNCAN</SPEAKER>
      <LINE>O valiant cousin! worthy gentleman!</LINE>
      </SPEECH>
      
      <SPEECH>
      <SPEAKER>Sergeant</SPEAKER>
      <LINE>As whence the sun 'gins his reflection</LINE>
      <LINE>Shipwrecking storms and direful thunders break,</LINE>
      <LINE>So from that spring whence comfort seem'd to come</LINE>
      <LINE>Discomfort swells. Mark, king of Scotland, mark:</LINE>
      <LINE>No sooner justice had with valour arm'd</LINE>
      <LINE>Compell'd these skipping kerns to trust their heels,</LINE>
      <LINE>But the Norweyan lord surveying vantage,</LINE>
      <LINE>With furbish'd arms and new supplies of men</LINE>
      <LINE>Began a fresh assault.</LINE>
      </SPEECH>
      
      <SPEECH>
      <SPEAKER>DUNCAN</SPEAKER>
      <LINE>Dismay'd not this</LINE>
      <LINE>Our captains, Macbeth and Banquo?</LINE>
      </SPEECH></ACT>"

    analyzer = Analyzer.new(file: speeches_xml)
    parsed_speeches = analyzer.analyze_speeches
    expect(parsed_speeches.count).to eq 3
    expect(parsed_speeches).to eq [
      {speaker: 'Duncan', lines: 1},
      {speaker: 'Sergeant', lines: 9},
      {speaker: 'Duncan', lines: 2}
    ]

    analyzed_speakers = analyzer.analyze_speakers
    expect(analyzed_speakers).to eq [
      {name: 'Sergeant', lines: 9},
      {name: 'Duncan', lines: 3}
    ]
  end
end
