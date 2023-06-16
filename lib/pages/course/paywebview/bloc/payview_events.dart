abstract class PayWebViewEvents{
  const PayWebViewEvents();
}


class TriggerWebView extends PayWebViewEvents{
  final String url;
  const TriggerWebView(this.url);

}