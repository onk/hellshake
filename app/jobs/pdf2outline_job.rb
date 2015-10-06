class Pdf2outlineJob < ActiveJob::Base
  queue_as :default

  def perform(presentation)
    pdf_file_path = presentation.pdf_file.path

    # pdf -> txt に xpdf を使う
    text = `pdftotext -nopgbrk #{pdf_file_path} -`
    presentation.with_lock do
      outline = presentation.presentation_outline || presentation.build_presentation_outline
      outline.body = text
      outline.save!
    end
  end
end
