# frozen_string_literal: true

module Hl7v2
  class Parser
    SEGMENT_DELIM = "\r".freeze # セグメントターミネータ
    FIELD_DELIM = "|".freeze # フィールドセパレータ
    ELEMENT_DELIM = "^".freeze # 成分セパレータ
    REPEAT_DELIM = "~".freeze # 反復セパレータ

    attr_reader :raw_message

    def initialize(raw)
      @raw_message = raw
    end

    def based_datatypes
      @based_datatypes ||= File.open(Pathname.new(File.dirname(File.expand_path(__FILE__))).join('json').join('HL7_DATATYPE.json')) do |io|
        JSON.load(io)
      end
    end

    def based_segments
      @based_segments ||= File.open(Pathname.new(File.dirname(File.expand_path(__FILE__))).join('json').join('HL7_SEGMENT.json')) do |io|
        JSON.load(io)
      end
    end

    def parse
      # セグメント分割
      raw_segments = raw_message.gsub!("\n", SEGMENT_DELIM).split(SEGMENT_DELIM).compact.reject(&:empty?)
      results = []

      raw_segments.each do |raw_segment|
        # メッセージ終端の場合は処理を抜ける
        break if /\x1c/.match(raw_segment)
       
        # フィールド分割
        raw_fields = raw_segment.split(FIELD_DELIM)
        segment_id = raw_fields[0]
        segment = create_segment(segment_id)
        segment_idx = 0

        segment.each do |field|

        end
        
      end
    end

    # 空のセグメントオブジェクトを生成する
    def create_segment(id)
      Marshal.load(Marshal.dump(based_segments[id])).map{ |c| c.map{ |k, v| [k.to_sym, v] }.to_h }
    end

  end
end
__END__

raw = <<~MSG
  MSH|^~\&|HL7v2|1319999999|HL7FHIR|1319999999|20160821161523||RDE^O11^RDE_O11|201608211615230143|P|2.5||||||~ISOIR87||ISO 2022-1994
  PID|||1000000001^^^^PI||患者^太郎^^^^^L^I~カンジャ^タロウ^^^^^L^P||19791101|M|||^^渋谷区^東京都^1510071^JPN^H^東京都渋谷区本町三丁目１２ー１||^PRN^PH^^^^^^^^^03-1234-5678|||||||||||N||||||N|||20161028143309
  IN1|1|06^組合管掌健康保険^JHSD0001|06050116|||||||９２０４５|１０|19990514|||||SEL^本人^HL70063
  ORC|NW|12345678||12345678_01|||||20160825|||123456^医師^春子^^^^^^^L^^^^^I~^イシ^ハルコ^^^^^^^L^^^^^P|||||01^内科^99Z01||||メドレークリニック|^^港区^東京都^^JPN^^東京都港区六本木３−２−１|||||||O^外来患者オーダ^HL70482
  RXE||103835401^ムコダイン錠２５０ｍｇ^HOT|1||TAB^錠^MR9P|TAB^錠^MR9P|01^１回目から服用^JHSP0005|||9|TAB^錠^MR9P||||||||3^TAB&錠&MR9P||OHP^外来処方^MR9P~OHI^院内処方^MR9P||||||21^内服^JHSP0003
  TQ1|||1013044400000000&内服・経口・１日３回朝昼夕食後&JAMISDP01|||3^D&日&ISO+|20160825
  RXR|PO^口^HL70162
  ORC|NW|12345678||12345678_01|||||20160825|||123456^医師^春子^^^^^^^L^^^^^I~^イシ^ハルコ^^^^^^^L^^^^^P|||||01^内科^99Z01||||メドレークリニック|^^港区^東京都^^JPN^^東京都港区六本木３−２−１|||||||O^外来患者オーダ^HL70482
  RXE||110626901^パンスポリンＴ錠１００ １００ｍｇ^HOT|2||TAB^錠^MR9P|TAB^錠^MR9P|01^１回目から服用^JHSP0005|||18|TAB^錠^MR9P||||||||6^TAB&錠&MR9P||OHP^外来処方^MR9P~OHI^院内処方^MR9P||||||21^内服^JHSP0003
  TQ1|||1013044400000000&内服・経口・１日３回朝昼夕食後&JAMISDP01|||3^D&日&ISO+|20160825
  RXR|PO^口^HL70162
  ORC|NW|12345678||12345678_02|||||20160825|||123456^医師^春子^^^^^^^L^^^^^I~^イシ^ハルコ^^^^^^^L^^^^^P|||||01^内科^99Z01||||メドレークリニック|^^港区^東京都^^JPN^^東京都港区六本木３−２−１|||||||O^外来患者オーダ^HL70482
  RXE||100795402^ボルタレン錠２５ｍｇ^HOT|1||TAB^錠^MR9P|||||10|TAB^錠^MR9P||||||||||OHP^外来処方^MR9P~OHI^院内処方^MR9P||||||22^頓用^JHSP0003
  TQ1|||1050110020000000&内服・経口・疼痛時&JAMISDP01||||20160825||||1 日2 回まで|||10
  RXR|PO^口^HL70162
  ORC|NW|12345678||12345678_03|||||20160825|||123456^医師^春子^^^^^^^L^^^^^I~^イシ^ハルコ^^^^^^^L^^^^^P|||||01^内科^99Z01||||メドレークリニック|^^港区^東京都^^JPN^^東京都港区六本木３−２−１|||||||O^外来患者オーダ^HL70482
  RXE||106238001^ジフラール軟膏０．０５％^HOT|""||""|OIT^軟膏^MR9P||||2|HON^本^MR9P||||||||||OHP^外来処方^MR9P~OHO^院外処方^MR9P||||||23^外用^JHSP0003
  TQ1|||2B74000000000000&外用・塗布・１日４回&JAMISDP01||||20160825
  RXR|AP^外用^HL70162|77L^左手^JAMISDP01
MSG

Hl7v2::Parser.new(raw).parse

https://github.com/panates/hl7v2/blob/master/lib/dictionary/2.5/segments.js