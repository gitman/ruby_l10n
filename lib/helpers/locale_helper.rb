require 'action_view'
require 'config_service'
require 'logging'

require_relative './date_time_maps'

class LocaleHelper
  include ActionView::Helpers::NumberHelper
  include DateTimeMaps


  def initialize(locale, options = {})
    @locale = locale
    config = ConfigService.load_config("locales/#{locale}.yml")
    @format_data = config[locale]

    if options['logger']
      @logger = options['logger']
    else
      @logger = ::Logging::Logger.new("locale_helper_#{@locale}_#{self.object_id}")
      current_env = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || options['env'] || 'development'
      #raise File.expand_path("../../log/#{current_env}.log")
      @logger.add_appenders(Logging.appenders.stdout, Logging.appenders.file(File.expand_path("./log/#{current_env}.log")))
    end

  end

  def logger
    @logger
  end

  def default_date(date)
    date_to_string(date, 'default')
  end

  def long_date(date)
    date_to_string(date, 'long')
  end

  def short_date(date)
    date_to_string(date, 'short')
  end

  def day_name(english_name)
    get_day_name(english_name,'day_names')
  end

  def short_day_name(english_name)
    get_day_name(english_name,'abbr_day_names')
  end

  def month_name(english_name)
    get_month_name(english_name, 'month_names')
  end

  def short_month_name(english_name)
    get_month_name(english_name, 'abbr_month_names')
  end


  def default_time(time)
    time_to_string(time, 'default')
  end

  def history_time(time)
    time.strftime(@format_data['time']['formats']['history'])
  end

  def long_time(time)
    time_to_string(time,'long')
  end

  def short_time(time)
    time_to_string(time, 'short')
  end

  def only_time(time)
    time_to_string(time, 'time')
  end

  def lc_number(number)

    return '' if (number.nil? || number == '')
    number_with_delimiter(number, number_delimiter, number_separator)

  end

  def lc_number_with_precision(number, precision = number_precision)
    st = localize_number(number)
    if st =~  Regexp.compile(number_separator)
      return ($` + $& + $'[0,precision])
    end

    return st
  end

  def lc_currency(number, unit = @format_data['number']['currency']['format']['unit'])
     return number if number.to_s =~ /Infinity/ or number.to_s == 'NaN'
  precision = @format_data['number']['currency']['format']['precision']
    separator = number_separator
    result = number_to_currency(number,:precision => precision,
                               :unit => unit,
                               :format => @format_data['number']['currency']['format']['format'],
                               :separator => separator,
                               :delimiter => number_delimiter
                              )
    #logger.error("separator --> #{separator} --- result --> #{result}")
    int, dec = result.split(separator)
    if (!dec.nil? && dec.length < precision)
      (precision - dec.length).times {
        result += '0'
      }
    end
    result
  end

  def lc_currency_number_only(number)
    lc_currency(number,'')
  end

  def lc_label(label, *args)
    st = @format_data['labels'][label]

    if st.nil?
      logger.error("\n***** Warning: label #{label} is not found in the locale #{@locale}.\n\n")
      # st = LOCALES[US_LOCALE].lc_label(label, args)
      return "#{lc_label('label_not_found')} #{label}"
    end

    if (!args.empty?)
      st2 = st.dup
      st.scan(/\{\{(\d)+\}\}/) { |word|
        st2.sub!(Regexp.compile("\\{\\{#{word[0]}\\}\\}"), args[word[0].to_i].to_s)

      }
      return st2
    end

    return st
  end


  def number_precision
    @format_data['number']['format']['precision']
  end

  def currency_precision
    @format_data['number']['currency']['format']['precision']
  end

  def number_separator
    @format_data['number']['format']['separator']
  end

  def number_delimiter
    @format_data['number']['format']['delimiter']
  end

  def get_hst_format
    @format_data['time']['formats']['history']
  end

  private

  def date_to_string(date, format)
    return '' if date.nil?
  if date.is_a? ActiveSupport::TimeWithZone
      date = date.to_date
    end

    raise "Invalid type #{date} of class #{date.class}" unless [Date, Time, DateTime].include? date.class
    result = date.strftime(@format_data['date']['formats'][format])
    sub_month(result, format)
  end

  def time_to_string(time, format)
    raise "Invalid type #{time} of class #{time.class}" unless [Time, DateTime].include? time.class
    result = time.strftime(@format_data['time']['formats'][format])
    return result if format == 'time'
    result = sub_month(result, format)
    sub_day(result, format)
  end

  def get_day_name(english_name, format)
    english_name = "#{english_name[0,3]}" if (english_name.size >= SHORT_SIZE)
    @format_data['date'][format][DAY_NAME_MAP[english_name]]
  end

  def get_month_name(english_name, format)
    if (english_name.size >= SHORT_SIZE )
      english_name = "#{english_name[0,3]}"
    end
    @format_data['date'][format][MONTH_NAME_MAP[english_name]]
  end

  def sub_month(str_date, format)
    idx = (str_date =~ eval("#{format.upcase}_MONTH_REGEX"))
    return str_date unless idx
    english_name = $&
    month = (format == 'short')? short_month_name(english_name) :
                                 month_name(english_name)
    $` + month + $'
  end

  def sub_day(str_time, format)
    idx = (str_time =~ eval("#{format.upcase}_DAY_REGEX"))
    return str_time unless idx

    english_name = $&
    day = (format == 'short')? short_day_name(english_name) :
                                 day_name(english_name)
    $` + day + $'
  end

end