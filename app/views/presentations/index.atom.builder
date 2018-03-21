atom_feed(language: "ja-JP",
          root_url: root_url,
          url:      request.original_url,
          id:       root_url) do |feed|
  feed.title    "HellShake"
  feed.subtitle "プレゼンテーション一覧"
  feed.updated  Presentation.is_public.maximum(:updated_at)
  feed.author   "HellShake"

  @presentations.each do |presentation|
    feed.entry(presentation,
               url:       presentation_url(presentation.user.username, presentation.slug),
               id:        presentation_url(presentation.user.username, presentation.slug),
               published: presentation.published_at,
               updated:   presentation.updated_at) do |item|
      item.title(presentation.title)
      item.content("<pre>#{presentation.presentation_outline.try(:body)}</pre>", type: "text")
      item.author {|author| author.name(presentation.user.name) }
    end
  end
end
