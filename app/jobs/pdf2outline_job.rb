class Pdf2outlineJob < ActiveJob::Base
  queue_as :default

  def perform(presentation)
    pdf_file_path = presentation.pdf_file.path

    # pdf -> txt に xpdf を使う
    text = `pdftotext -nopgbrk #{pdf_file_path} -`
    presentation.create_presentation_outline(body: text)
  end
end
