$ ->
  # img の height を可変にしたいので
  $(window).on "load", ->
    if $(".grid").length > 0
      new Masonry(".grid", {
          itemSelector: ".grid-item",
          columnWidth: 250,
          gutter: 10,
          fitWidth: true
        }
      )
  $(".datepicker").pickadate(
    monthsFull: ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"],
    monthsShort: ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"],
    format: "yyyy/mm/dd",
    selectYears: true,
    selectMonths: true,
    clear: false
  )
  $(".tagit").tagit()
  $('.modal-trigger').leanModal();
