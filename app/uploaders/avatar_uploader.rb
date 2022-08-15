class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def size_range
    0.byte..5.megabytes
  end

  def extension_allowlist
    %w(jpg jpeg gif png)
  end
end
