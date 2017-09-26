class Player < ActiveRecord::Base
  belongs_to :organization
  belongs_to :loop_asset
  belongs_to :campaign
  belongs_to :admin_hardware_type, :class_name => "Admin::HardwareType"
  belongs_to :admin_pay_program, :class_name => "Admin::PayProgram"
  serialize :diagnostics, Hash

  validates :name, length: { maximum: 50 }
  validates :description, length: { maximum: 500 }
  validates :admin_hardware_type, presence: true
  validates :serial_number, presence: true
  validates :admin_pay_program, presence: true

  before_save :bubble_update, if: "self.campaign_id_changed?"

  def bubble_update 
    self.touch(:last_update_stamp)
  end

  private

    # Cusom Validations
    # Ensure the loop asset belongs to the organization
    def loop_asset_accessible
      if loop_asset.organization != self.organization
        errors.add(:loop_asset, "is not accessable")
      end
    end
end
