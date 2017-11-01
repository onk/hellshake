class Pdf2pngJob < ActiveJob::Base
  queue_as :default

  def perform(presentation)
    Dir.mktmpdir do |dir|
      png_basename = File.basename(pdf_file_path = presentation.pdf_file.path, ".*")
      # pdf の 1 ページ目のみを png に変換
      `pdftocairo -png -singlefile #{pdf_file_path} #{dir}/#{png_basename}`

      # https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-%22Upload%22-from-a-local-file
      # carrier_wave 内で close が呼ばれる
      presentation = Presentation.lock.find(presentation.id)
      presentation.image_file = File.open("#{dir}/#{png_basename}.png")
      presentation.save!
    end
  end
end
