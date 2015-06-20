class Pdf2pngJob < ActiveJob::Base
  queue_as :default

  def perform(presentation)
    pdf_file_path = presentation.pdf_file.path
    png_file_path = pdf_file_path.sub(/pdf$/, "png")
    # pdf -> png した画像を置いておく
    `pdftocairo -png -l 1 #{pdf_file_path} #{png_file_path}`
  end
end
