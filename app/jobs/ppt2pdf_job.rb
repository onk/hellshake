class Ppt2pdfJob < ActiveJob::Base
  queue_as :default

  def perform(presentation)
    original_file_path = presentation.original_file.path
    pdf_file_name = SecureRandom.hex(16) + ".pdf"
    pdf_file_uploader = presentation.pdf_file
    pdf_file_path = File.join(pdf_file_uploader.root, pdf_file_uploader.store_dir, pdf_file_name)

    Dir.mktmpdir { |dir|
      ext = File.extname(original_file_path)
      case ext
      when ".ppt", ".pptx"
        # ppt, pptx -> pdf に libreoffice を使う
        `soffice --headless --convert-to pdf --outdir #{dir} #{original_file_path}`
        pdf_file = Dir.glob("#{dir}/*.pdf").first
        FileUtils.mkdir_p(File.dirname(pdf_file_path))
        FileUtils.mv(pdf_file, pdf_file_path)
      when ".pdf"
        # pdf -> pdf は libreoffice で変換できないのでそのまま使う
        FileUtils.mkdir_p(File.dirname(pdf_file_path))
        FileUtils.cp(original_file_path, pdf_file_path)
      else
        raise "unknown file type: #{ext}"
      end
      presentation[:pdf_file] = pdf_file_name
      presentation.save

      Pdf2outlineJob.perform_later(presentation)
      Pdf2pngJob.perform_later(presentation)
    }
  end
end
