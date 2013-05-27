class HeaderAnimation
  # 10 - 80 - 10
  constructor: ->
    @parts = [$('.part1'), $('.part2'), $('.part3')]
    @largeLetterSpacing  = 100
    @medianLetterSpacing = 50
    @noLetterSpacing     = -1
    @mainWidth           = $(window).width()
    @contentWidth        = $('.span12').width()
    @littleZoneWidth     = @mainWidth * 0.33
    @largeZoneWidth      = @mainWidth - (@littleZoneWidth * 2)
    @mouseMoveHandler()

  animate: (part) ->
    otherParts = _.difference(@parts, [part])
    part.animate          { letterSpacing: @largeLetterSpacing }, { duration: 600, queue: false }
    otherParts[0].animate { letterSpacing: @noLetterSpacing }, { duration: 600, queue: false }
    otherParts[1].animate { letterSpacing: @noLetterSpacing }, { duration: 600, queue: false }

  reset: ->
    _.each @parts, (part) =>
      part.animate { letterSpacing: @medianLetterSpacing }, { duration: 600, queue: false }

  mouseMoveHandler: ->
    $(document).mousemove (m) =>
      if m.pageX < @littleZoneWidth and not @inZone1
        @inZone1 = true
        @inZone2 = false
        @inZone3 = false
        @animate(@parts[0])
      else if (m.pageX > (@littleZoneWidth + @largeZoneWidth)) and not @inZone3
        @inZone1 = false
        @inZone2 = false
        @inZone3 = true
        @animate(@parts[2])
      else if (m.pageX > @littleZoneWidth) and (m.pageX < (@littleZoneWidth + @largeZoneWidth)) and not @inZone2
        @inZone1 = false
        @inZone2 = true
        @inZone3 = false
        @reset()
anim = new HeaderAnimation
