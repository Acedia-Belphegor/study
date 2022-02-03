class Patient < ApplicationRecord
  include PatientSearchable
  
  has_many :patient_addresses, dependent: :destroy # has_many :through
  has_many :addresses, through: :patient_addresses # Address model に patient_id は実装されていないけど patient.addresses で参照できるようになる
  has_many :insurances, dependent: :destroy

  has_one :memo, class_name: "PatientMemo", dependent: :destroy, inverse_of: :patient

  validates :gender, inclusion: { in: %w[male female other unknown] }

  class Age
    attr_reader :age
    def initialize(birthdate, base_date)
      @birthdate = birthdate
      @base_date = base_date
      @age = (base_date.strftime("%Y%m%d").to_i - birthdate.strftime("%Y%m%d").to_i) / 10000
    end

    # 新生児
    def newborn?
      @base_date < @birthdate + 28.days
    end

    # ３歳になった次の月
    def under3age?
      @base_date < (@birthdate + 3.years + 1.month).beginning_of_month
    end

    # １５歳になった次の月
    def under15age?
      @base_date < (@birthdate + 15.years + 1.month).beginning_of_month
    end

    # 未就学児
    def preschooler?
      if age == 6
        six_years_old_preschooler?
      elsif age > 6
        false
      else
        true
      end
    end

    # 6歳のときの未就学児判定
    # 今年度に誕生日を迎えた6歳 -> 未就学児
    # 今年度に誕生日を迎えていない6歳 -> 小学生
    def six_years_old_preschooler?
      base_month = @base_date.strftime("%m").to_i
      base_date_md = @base_date.strftime("%m%d").to_i
      birthdate_md = @birthdate.strftime("%m%d").to_i
      # base_dateが4月から12月
      if 4 <= base_month && base_month <= 12
        return birthdate_md <= base_date_md && "0402".to_i <= birthdate_md
      end

      # base_dateが1月から3月
      birthdate_md <= base_date_md || "0402".to_i <= birthdate_md
    end

    # 高齢受給者
    # 高齢受給者の条件 https://www.kyoukaikenpo.or.jp/shibu/kagoshima/cat080/2013042401/
    # > 70歳の誕生日の翌月の１日（誕生日が月の初日の場合は誕生日当日）
    def older_recipient?
      actual_age = age.to_i
      if actual_age < 70
        false
      elsif actual_age == 70
        if @birthdate.day == 1
          @base_date >= @birthdate + 70.years
        else
          @base_date >= (@birthdate + 70.years + 1.month).beginning_of_month
        end
      else
        true
      end
    end

    def to_i
      age
    end
  end

  # 現在の年齢
  def age(base_date = Date.current)
    Age.new(self.birth_date, base_date)
  end  
end
