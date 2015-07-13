$ ->
  # img の height を可変にしたいので
  $(window).load ->
    if $(".grid").length > 0
      new Masonry(".grid", {
          itemSelector: ".grid-item",
          columnWidth: 300,
          gutter: 10,
          isFitWidth: true
        }
      )
