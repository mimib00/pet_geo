class ChatHeadModel {
  ChatHeadModel({
    this.haveNewMsg = false,
    this.msgCounter = false,
    this.name,
    this.msg,
    this.time,
  });

  bool? haveNewMsg;
  bool? msgCounter;
  // ignore: prefer_typing_uninitialized_variables
  var name, msg, time;
}
