require './app/interactors/replace_character'

RSpec.describe ReplaceCharacter do
  describe '.call' do
    it 'works' do
      expect(ReplaceCharacter.call(input: "髙").output).to eq "高" # 髙 => 高
    end
  end
end