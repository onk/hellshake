$ ->
  # img の height を可変にしたいので
  $(window).load ->
    new Masonry(".grid", {
        itemSelector: ".grid-item",
        columnWidth: 300,
        gutter: 10,
        isFitWidth: true
      }
    )
