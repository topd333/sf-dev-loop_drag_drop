class TemplateAddon < ActiveRecord::Base
  belongs_to :organization
  has_attached_file :file

  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => ["application/javascript", "text/css"]
  validates_attachment_size :file, :in => 0..1024.kilobytes

  before_create :gen_file_name

  private
  	def gen_file_name
  		extension = File.extname(file_file_name).downcase
		self.file.instance_write(:file_name, "#{SecureRandom.uuid}#{extension}")
	end
end
