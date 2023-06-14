enum MessageType {
  text('text'),
  image('image'),
  audio('audio'),
  video('video'),
  gif('gif');

  final String type;

  const MessageType(this.type);
}

//파이어스토어에서 받아온 json String을 Enum으로 바꾸기 위한 익스텐션
extension ConvertMessage on String {
  //extension은 기존의 값을 변환하지 않으면서 기능을 추가하고 싶을 때 사용
  //이 코드에서는 String Type에다가 toEnum을 추가해줌
  //따라서 앞으로는 '문자열'.toEnum()이 사용 가능해짐
  MessageType toEnum() {
    //this : 이 메서드를 호출한 문자열 객체를 가리킴
    switch (this) {
      case 'text':
        return MessageType.text;
      case 'image':
        return MessageType.image;
      case 'audio':
        return MessageType.audio;
      case 'video':
        return MessageType.video;
      case 'gif':
        return MessageType.gif;

      default:
        return MessageType.text;
    }
  }
}
