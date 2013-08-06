require 'stringio'
class StringFile < StringIO
  def original_filename
    "text submission"
  end

  def content_type
    "text/plain"
  end

  def tempfile
    self
  end
end
