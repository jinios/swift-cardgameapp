## 완성화면

- 게임 성공 화면
- <img src="./Screenshot/cardgame_finish.gif" width="50%">


## 주요 기능
- [솔리테어 카드게임](https://ko.wikipedia.org/wiki/클론다이크)을 구현한다.
- 더블탭과 드래그로 카드를 옮길 수 있다.
- 디바이스를 흔들면 (Shake Gesture)게임이 새로 시작된다.
- 게임을 완료하면 안내메시지를 표시한다.

## 사용한 기술
- Custom View, Gesture Recognizer, View Animation, UIAlertController,

## 설계
> ViewModel 활용: 기존의 MVC를 유지하되, View를 Passive하게 만들고 View Model담당 객체를 추가

- 이 프로젝트에서 가장 깊이 경험했던 부분은 복잡한 뷰 계층구조에서 발생하는 이벤트 감지와 처리를 위해 최대한 효과적으로 로직을 분리하는 것이었습니다.
- 따라서 복잡한 계층 구조를 가진 객체의 역할을 분리하고, 최대한 Passive한 View를 만들어서 View Model만으로도 게임 로직이 성립되도록 구현했습니다.
- 또한 이벤트 수신과 처리에 대한 결과를 반영하기위한 View update flow의 단방향성에 신경써서 작업하였습니다.

## 주요 객체 역할분담
- 카드의 위치에 따라 Foundation, CardDeck, CardStack으로 객체 역할 구분
- 카드게임 전체를 관할하는 CardGameManager 클래스를 Singleton객체로 설계하여 하나의 앱 당 하나의 CardGameManager만 존재하도록 구현하고, 게임이 재시작됐을때 새롭게 초기화된 게임매니저 객체를 할당

#### Model
- CardGameManager: 카드게임 전체를 관할하는 모든 모델들의 최상위모델
- Card: 카드한장을 나타내는 객체
- CardDeck: 52장의 카드를 모아두는 카드덱
- CardStack: 필드에 놓여진 카드 스택 하나
#### View - ViewModel
- DeckManager - CardDeckView: CardDeck에 있는 카드뷰들을 담당
- WholeStackManager - CardStacksView: 전체 CardStack 7개를 담당
- StackManager - OneStack: CardStack 1개를 담당
- FoundationManager - FoundationView: Foundation 담당 (카드가 순서대로 맞춰져서 쌓이는 곳)
#### Others
- FrameCalculator: 각 서브뷰에서 수신되는 이벤트(DoubleTap, PanGesture)에 따른 카드뷰들의 위치를 계산하는 객체
- (카드게임앱은 하나의 루트뷰를 Deck, Foundation, Stack의 세 영역으로 나누고 프레임을 계산해서 서브뷰를 띄운 방식으로 구현함. 따라서 ViewController가 제스처를 수신하고 이벤트를 처리할때 복잡한 프레임 계산을 담당하는 객체가 필요했음.)


## 학습내용
### Custom View와 UIView의 생성자
- [블로그에 정리한 링크](https://jinios.github.io/ios/2018/04/15/customView_init/)

### 사용자의 이벤트가 인식되는 구조
> [Handling UIKit Gestures](https://jinios.github.io/ios/2018/07/05/handling_uikit_gestures/) 번역한 것 블로그에 정리

1. 사용자는 디바이스에서 특정 액션을 취함 (터치, 줌 등)
2. 그 액션에 해당하는 이벤트가 시스템에 의해 생성, UIKit에서 생성한 port를 통해 앱에 전달
3. 이벤트들은 앱 내부적으로 queue에 저장(FIFO)
4. UIApplication객체가 가장 먼저 이 이벤트를 받아서 어떤 동작이 취해질 지 결정
  - 터치 이벤트의 경우 main window객체가 인식하고 window객체가 다시 터치가 발생한 view로 이벤트를 전달함
  - 다른 이벤트들도 다양한 app객체에 따라 조금씩 다르게 동작

### 주로 발생되는 이벤트 처리
- Touch이벤트: **터치 이벤트가 발생한 view객체** 로 전달
  - view는 응답을 할 줄 아는(Responder) 객체이므로 터치 이벤트가 발생한 뷰 객체로 전달됨. 만약 해당 뷰에서 처리되지 않는 터치이벤트는 Responder chain을 따라 계속 내려가게됨
- Remote control / Shake motion events: **First responder object객체**
  - 미디어콘텐츠의 재생이나 되감기 등과같은 remote control이벤트는 주로 헤드폰같은 악세사리에서 발생
- Redraw: **업데이트가 필요한 객체**
  - Redraw 이벤트는 이벤트 객체를 갖지는 않고, 단순히 업데이트가 필요한 view객체에 요청
- **참고**, 이벤트 소스 종류
  - 입력소스(input source): 다른 thread나 어플리케이션에서 전달되는 메시지 이벤트(비동기식)
  - 타이머소스(timer source): 예정시간이나 반복수행간격에 따라 발생하는 이벤트(동기식)
- **Touch나 Remote Control** 같은 이벤트는 앱의 Responder객체를 통해 처리된다.
- Responder객체는 앱의 모든 곳에 존재
  - UIApplication, 커스텀 view객체, ViewController객체 모두 Responder객체에 해당된다.

Touches, Presses, and Gestures
UIResponder객체는 앱의 이벤트를 핸들링한다. 사용자로부터 입력되는 터치나 제스쳐 이벤트는 UIEvent객체로써 앱과 연결된다.
- [UIResponder](https://developer.apple.com/documentation/uikit/uiresponder)- An abstract interface for responding to and handling events.
- [UIEvent](https://developer.apple.com/documentation/uikit/uievent) - An object that describes a single user interaction with your app.

- Touches : [Handling Touches in Your View](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_touches_in_your_view)
- Gestures(press, tap): [Handling UIKit Gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures)
