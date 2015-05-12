require_relative '../../spec_helper'

ENGLISH_DAY_NAMES = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
FRENCH_DAY_NAMES  = %w(Dimanche Lundi Mardi Mercredi Jeudi Vendredi Samedi)

ENGLISH_MONTH_NAMES = %w(January February March April May June July August September October November December)

FRENCH_MONTH_NAMES       = %w(Janvier Février Mars Avril Mai Juin Juillet Août Septembre Octobre Novembre Décembre)
FRENCH_ABBRV_MONTH_NAMES = %w(Jan Fév Mar Avr Mai Juin Juil Août Sept Oct Nov Déc)


describe LocaleHelper do
  before do 
    @test_time = DateTime.parse('2015-05-12 11:40:52 -0700')
  end

  describe 'lc_label' do
    
    describe 'en-US' do
      before do
        @lc_helper = LocaleHelper.new('en-US')
      end

      it 'prints Thanks for label thanks' do
        @lc_helper.lc_label('thanks').must_equal('Thanks')
      end

      it 'intrapolates string correctly' do
        @lc_helper.lc_label('i_like_systems', 'Mac', 'Linux').must_equal('I like Mac and Linux')
      end

      it 'prints Label not found if the label does not exist' do
        @lc_helper.lc_label('nonexistent_label').must_equal('Label not found: nonexistent_label')
      end
    end # en-US

    describe 'fr' do
      before do
        @lc_helper = LocaleHelper.new('fr')
      end

      it 'prints Merci label thanks' do
        @lc_helper.lc_label('thanks').must_equal('Merci')
      end

      it 'intrapolates string correctly' do
        @lc_helper.lc_label('i_like_systems', 'Mac', 'Linux').must_equal('Je aime Mac et Linux')
      end

      it 'prints Étiquette non trouvé if the label does not exist' do
        @lc_helper.lc_label('nonexistent_label').must_equal('Étiquette non trouvé: nonexistent_label')
      end
    end # fr


    it 'throws an exception if initialized with nonexistent locale' do
      proc { LocaleHelper.new('nonexistent') }.must_raise(RuntimeError)
    end
  end # lc_label

  describe 'common Date/Time failures' do
    before do
      @lc_helper = LocaleHelper.new('en-US')
    end

    it 'returns empty string if the argument is nil' do
      @lc_helper.default_date(nil).must_equal('')  
    end

    it 'raises exception if the argument is not a Date/Time' do
      proc { @lc_helper.default_date(12345) }.must_raise(RuntimeError)
    end
  end

  describe 'date/time en-US' do
    before do
      @lc_helper = LocaleHelper.new('en-US')
    end

    it ' prints default_date' do
      @lc_helper.default_date(@test_time).must_equal('05/12/2015')
    end

    it 'prints long_date' do
      @lc_helper.long_date(@test_time).must_equal('May 12 2015')
    end

    it 'prints short_date' do
      @lc_helper.short_date(@test_time).must_equal('May 12')
    end

    it 'prints day_name' do
      ENGLISH_DAY_NAMES.each_with_index do |en_day_name, idx|
        @lc_helper.day_name(en_day_name).must_equal(ENGLISH_DAY_NAMES[idx])
      end
    end

    it 'prints short_day_name' do
      ENGLISH_DAY_NAMES.each_with_index do |en_day_name, idx|
        @lc_helper.short_day_name(en_day_name).must_equal(ENGLISH_DAY_NAMES[idx][0..2])
      end
    end

    it 'prints month_name' do
      ENGLISH_MONTH_NAMES.each_with_index do |en_month_name, idx|
        @lc_helper.month_name(en_month_name).must_equal(ENGLISH_MONTH_NAMES[idx])
      end
    end

    it 'prints short_month_name' do
      ENGLISH_MONTH_NAMES.each_with_index do |en_month_name, idx|
        @lc_helper.short_month_name(en_month_name).must_equal(ENGLISH_MONTH_NAMES[idx][0..2])
      end
    end

    it 'prints default_time' do
      @lc_helper.default_time(@test_time).must_equal('2015 May 12 11:40AM')
    end

    it 'prints history_time' do
      @lc_helper.history_time(@test_time).must_equal('05/12/2015 11:40AM')
    end

    it 'prints long_time' do
      @lc_helper.long_time(@test_time).must_equal('Tuesday 2015 May 12 11:40:52AM -07:00')
    end

    it 'prints short_time' do
      @lc_helper.short_time(@test_time).must_equal('May 12 11:40AM')
    end

    it 'prints only_time' do
      @lc_helper.only_time(@test_time).must_equal('11:40AM')
    end
  end # date en-US

  describe 'date/time fr' do
    before do
      @lc_helper = LocaleHelper.new('fr')
    end

    it ' prints default_date' do
      @lc_helper.default_date(@test_time).must_equal('12/05/2015')
    end

    it 'prints long_date' do
      @lc_helper.long_date(@test_time).must_equal('12 Mai 2015')
    end

    it 'prints short_date' do
      @lc_helper.short_date(@test_time).must_equal('12 Mai')
    end

    it 'prints day_name' do
      ENGLISH_DAY_NAMES.each_with_index do |en_day_name, idx|
        @lc_helper.day_name(en_day_name).must_equal(FRENCH_DAY_NAMES[idx])
      end
    end

    it 'prints short_day_name' do
      ENGLISH_DAY_NAMES.each_with_index do |en_day_name, idx|
        @lc_helper.short_day_name(en_day_name).must_equal(FRENCH_DAY_NAMES[idx][0..2])
      end
    end

    it 'prints month_name' do
      ENGLISH_MONTH_NAMES.each_with_index do |en_month_name, idx|
        @lc_helper.month_name(en_month_name).must_equal(FRENCH_MONTH_NAMES[idx])
      end
    end

    it 'prints short_month_name' do
      ENGLISH_MONTH_NAMES.each_with_index do |en_month_name, idx|
        @lc_helper.short_month_name(en_month_name).must_equal(FRENCH_ABBRV_MONTH_NAMES[idx])
      end
    end

    it 'prints default_time' do
      @lc_helper.default_time(@test_time).must_equal('12 Mai 2015 11:40')
    end

    it 'prints history_time' do
      @lc_helper.history_time(@test_time).must_equal('12-05-2015 11:40AM')
    end

    it 'prints long_time' do
      @lc_helper.long_time(@test_time).must_equal('Mardi 12 Mai 2015 11:40:52 -07:00')
    end

    it 'prints short_time' do
      @lc_helper.short_time(@test_time).must_equal('12 Mai 11:40')
    end

    it 'prints only_time' do
      @lc_helper.only_time(@test_time).must_equal('11:40')
    end
  end # date fr

end