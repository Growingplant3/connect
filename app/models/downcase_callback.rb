class DowncaseCallback
  def self.replace_to_half_num(string)
    string.tr("０-９", "0-9")
  end
end
