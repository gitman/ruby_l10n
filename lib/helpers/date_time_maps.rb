module DateTimeMaps
  
  SHORT_SIZE = 3
  
  DAY_NAME_MAP = {'Sun' => 0, 'Mon' => 1, 'Tue' => 2,
                  'Wed' => 3, 'Thu' => 4, 'Fri' => 5, 'Sat' => 6}
  
  MONTH_NAME_MAP = {'Jan' => 0, 'Feb' => 1, 'Mar' => 2, 'Apr' => 3,
                    'May' => 4, 'Jun' => 5, 'Jul'  => 6, 'Aug' => 7,
                    'Sep' => 8, 'Oct' => 9, 'Nov' => 10, 'Dec' => 11}
  
  SHORT_DAY_REGEX = /(Sun)|(Mon)|(Tue)|(Wed)|(Thu)|(Fri)|(Sat)/
  LONG_DAY_REGEX  = /(Sunday)|(Monday)|(Tuesday)|(Wednesday)|(Thursday)|(Friday)|(Saturday)/
  DEFAULT_DAY_REGEX = LONG_DAY_REGEX
  
  LONG_MONTH_REGEX   = /(January)|(February)|(March)|(April)|(May)|(June)|(July)|(August)|(September)|(October)|(November)|(December)/
  SHORT_MONTH_REGEX  = /(Jan)|(Feb)|(Mar)|(Apr)|(May)|(Jun)|(Jul)|(Aug)|(Sep)|(Oct)|(Nov)|(Dec)/
  DEFAULT_MONTH_REGEX = LONG_MONTH_REGEX
  
end



