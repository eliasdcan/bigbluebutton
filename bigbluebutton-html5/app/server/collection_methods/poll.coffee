# --------------------------------------------------------------------------------------------
# Private methods on server
# --------------------------------------------------------------------------------------------
@addPollToCollection = (poll, requester_id, users, meetingId) ->
  #copying all the userids into an array
  _users = []
  for user in users
    _users.push user.user.userid
  #adding the initial number of votes for each answer
  for answer in poll.answers
    answer.number = 0
  #adding all together and inserting into the Polls collection
  entry =
    poll_info:
      "meetingId": meetingId
      "poll": poll
      "requester": requester_id
      "users": _users
  Meteor.Polls.insert(entry)

@clearPollCollection = (meetingId) ->
  if meetingId?
    Meteor.Polls.remove({meetingId: meetingId}, Meteor.log.info "cleared Polls Collection (meetingId: #{meetingId}!")
  else
    Meteor.Polls.remove({}, Meteor.log.info "cleared Polls Collection (all Polls)!")