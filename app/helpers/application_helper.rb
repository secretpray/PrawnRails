module ApplicationHelper
  FLASH2COLOR = { success: 'bg-success', notice: 'bg-kidium', alert: 'bg-warning', error: 'bg-danger' }.freeze

  def set_flash_color(type = :notice)
    FLASH2COLOR[type.to_sym]
  end
end
