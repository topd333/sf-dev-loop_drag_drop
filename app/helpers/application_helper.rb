module ApplicationHelper
  def bytes_to_megabytes(size_in_bytes)
    size_in_bytes.to_f/1024/1024
  end

  def ms_to_human(duration_in_ms)
    return "" if duration_in_ms == nil
  	parts = ms_to_parts(duration_in_ms)
    if parts[:hours] >= 1
      format("%02d:%02d:%02d", parts[:hours], parts[:minutes], parts[:seconds])
    else
      format("%02d:%02d", parts[:minutes], parts[:seconds])
    end
  end

  def ms_to_words(duration_in_ms)
    return "" if duration_in_ms == nil
    parts = ms_to_parts(duration_in_ms)
    if parts[:hours] >= 1
      format("%02d hrs, %02d mins, %02d sec", parts[:hours], parts[:minutes], parts[:seconds])
    else
      format("%02d mins, %02d sec", parts[:minutes], parts[:seconds])
    end
  end

  def ms_to_parts(duration_in_ms)
    duration_in_seconds = duration_in_ms / 1000.0
    parts = Hash.new(0.0)
    parts[:seconds] = duration_in_seconds % 60
    parts[:minutes] = (duration_in_seconds / 60) % 60
    parts[:hours] = duration_in_seconds / 3600
    return parts
  end

  def determine_message_type(type)
    if type == 'notice'
      return 'info'
    elsif type == 'alert'
      return 'danger'
    else
      return 'info'
    end

  end

  # Used for admin namespace specific css and
  def admin?
    controller.class.name.split("::").first == "Admin"
  end

  def generate_checkbox(name)
    check_box_tag(name, '', false, class: 'sf-checkbox always-toggle', data: { skin: "square", color: "blue" })
  end

end
