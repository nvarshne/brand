# encoding: utf-8

class SupportUploader < CarrierWave::Uploader::Base

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(pdf xls xlsx doc docx ppt pptx jpg jpeg gif png)
  end

  # def filename
  #   "support.jpg" if original_filename
  # end

end
