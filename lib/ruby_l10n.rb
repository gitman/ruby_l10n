require_relative 'helpers/locale_helper'

def load_gem_lib(sub_path)
  spec = Gem::Specification.find_by_name('ruby_l10n')
  rb_files =  Dir.glob("#{spec.gem_dir}/lib/#{sub_path}/*.rb")
  rb_files.each { |rb_file| require rb_file }
rescue Exception => error
  # Who cares?
end

['helpers'].each do |sub_path|
  load_gem_lib(sub_path)
  rb_files =  Dir.glob("#{File.expand_path('.')}/lib/#{sub_path}/*.rb")
  rb_files.each { |rb_file| require rb_file }  
end