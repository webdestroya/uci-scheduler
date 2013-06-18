# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

COLOR_PALETTE = [
    {color: '#C4A883', borderColor: '#B08B59'},
    {color: '#A7A77D', borderColor: '#898951'},
    {color: '#85AAA5', borderColor: '#5C8D87'},
    {color: '#94A2BE', borderColor: '#5C8D87'},
    {color: '#8997A5', borderColor: '#627487'},
    {color: '#A992A9', borderColor: '#8C6D8C'},
    {color: '#A88383', borderColor: '#A87070'},
    {color: '#E6804D', borderColor: '#DD5511'},
    {color: '#F2A640', borderColor: '#EE8800'},
    {color: '#E0C240', borderColor: '#D6AE00'},
    {color: '#BFBF4D', borderColor: '#AAAA11'},
    {color: '#8CBF40', borderColor: '#66AA00'},
    {color: '#4CB052', borderColor: '#109618'},
    {color: '#65AD89', borderColor: '#329262'},
    {color: '#59BFB3', borderColor: '#22AA99'},
    {color: '#668CD9', borderColor: '#3366CC'},
    {color: '#668CB3', borderColor: '#336699'},
    {color: '#8C66D9', borderColor: '#6633CC'},
    {color: '#B373B3', borderColor: '#994499'},
    {color: '#E67399', borderColor: '#DD4477'},
    {color: '#D96666', borderColor: '#CC3333'}
  ]


colorEvent = (el, colorPair) ->
  $(el).css({
    'background-color': colorPair.color,
    'border': '1px solid ' + colorPair.borderColor
  });

  $('.wc-time', el).css({
    'background-color': colorPair.color,
    'border-left': 'none',
    'border-right': 'none',
    'border-top': 'none',
    'border-bottom': '1px solid ' + colorPair.borderColor
  });
  return

groupColorize = -> 
  tracking = {}
  $('.wc-cal-event').each (index, el) ->
    c = $(el).data().calEvent
    if !(c.groupId in tracking)
      tracking[c.groupId] = COLOR_PALETTE.shift()
    colorEvent(this, tracking[c.groupId])
    return
  return


$(document).ready ->
  return if $("#calendar").length == 0

  $("#calendar").weekCalendar
    timeslotsPerHour: 3
    businessHours:
      start: window.CALENDAR_JSON.start_hour - 1
      end: window.CALENDAR_JSON.end_hour + 1
      limitDisplay: true
    showHeader: false
    showColumnHeaderDate: false
    daysToShow: if window.CALENDAR_JSON.weekend then 7 else 5
    readonly: true
    useShortDayNames: true
    allowCalEventOverlap: true
    overlapEventsSeparate: true
    buttons: false
    dateFormat: ''
    height: -> 
      ((window.CALENDAR_JSON.end_hour - window.CALENDAR_JSON.start_hour + 2) * 60) + 95

  $("#calendar").weekCalendar 'gotoWeek', new Date(1999, 12, 3)

  #$("#calendar").weekCalendar 'loadEvents', window.SCHEDULE_JSON
  for event in window.CALENDAR_JSON.events
    $("#calendar").weekCalendar 'updateEvent', event

  groupColorize()
  return